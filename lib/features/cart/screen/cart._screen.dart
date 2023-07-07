import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercial_nodjs/features/address/screens/addrees_screen.dart';
import 'package:flutter_commercial_nodjs/features/cart/widget/cart_list.dart';
import 'package:flutter_commercial_nodjs/features/home/home_widgets.dart';
import 'package:flutter_commercial_nodjs/model/product.dart';

import '../../../logic/bloc_user/user_bloc.dart';
import '../services/services.dart';

//TODO : use orginal price to calculate
//TODO : use validation for all Situation
class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  ShoppingCartPageState createState() => ShoppingCartPageState();
}

class ShoppingCartPageState extends State<ShoppingCartPage> {
  void navigateToAddress(int price) {
    Navigator.pushNamed(context, AddreesScreen.routename, arguments: price);
  }

  @override
  Widget build(BuildContext context) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';
    double totalPrice = 0;
    double totalDiscount = 0;
    // ignore: unused_local_variable
    double totalPriceWithDiscount = 0;
    void calculateTotal(UserState state) {
      totalPrice = 0; //clear the value of totalPrice before calculating
      for (var i = 0; i < state.user.cart.length; i++) {
        var price = state.user.cart[i]['product']['price'];
        // debugPrint(price.toString());

        totalPrice += price * state.user.cart[i]['quantity'];
        totalDiscount += price * state.user.cart[i]['quantity'] * 0.1;
      }
      totalPriceWithDiscount = totalPrice - totalDiscount;
    }

    Future<bool> checkValidation(UserState state) async {
      List<bool> validationList = [];

      for (var i = 0; i < state.user.cart.length; i++) {
        Product product = Product.fromMap(state.user.cart[i]['product']);
        bool a =
            await CartServices().checkItemValidation(id: product.id.toString());
        validationList.add(a);
      }

      if (validationList.contains(false)) {
        return false;
      }
      return true;
    }

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        checkValidation(state);
        calculateTotal(state);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Shopping Cart'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                AdressBar(state: state),
                CartList(
                  state: state,
                ),
                FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.data == false) {
                      return const Text('validation is disabled');
                    }
                    return const SizedBox();
                  },
                  future: checkValidation(state),
                )
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text.rich(TextSpan(
                        children: [
                          TextSpan(text: ' جمع کل'),
                        ],
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold))),
                    Text(
                        ' ${totalPrice.round().toString().replaceAllMapped(reg, mathFunc)} ')
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8)),
                  width: 120,
                  height: 40,
                  child: Center(
                      child: InkWell(
                    onTap: () => navigateToAddress(totalPrice.toInt()),
                    child: const Text(
                      'تکمیل خرید',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
