import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercial_nodjs/features/account/screens/order_screen.dart';
import 'package:flutter_commercial_nodjs/features/account/services/services.dart';
import 'package:flutter_commercial_nodjs/features/account/widget/acount_gridview.dart';
import 'package:flutter_commercial_nodjs/features/account/widgets/consumable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../logic/bloc_user/user_bloc.dart';
import '../../../model/order.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List<Order>? orders;
  @override
  void initState() {
    super.initState();
    fetchOrder();
  }

  void fetchOrder() async {
    orders = await AccountService().getUserOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
              flexibleSpace: Container(),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      'lib/assets/images/logo.png',
                    ),
                  ),
                  Row(children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.notifications),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.search),
                    )
                  ])
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Text('Welcome ${state.user.name.toUpperCase()}',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AccountTopButton(
                    text: 'Orders',
                    func: () {
                      Navigator.pushNamed(context, OrderScreen.routeName);
                    },
                  ),
                  AccountTopButton(
                    text: 'Seller',
                    func: () {
                      debugPrint(state.user.type);
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AccountTopButton(
                    text: 'Log Out',
                    func: () async {
                      context.read<UserBloc>().add(CleanUser());
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.clear();
                      debugPrint(prefs.get('x-auth-token').toString());
                    },
                  ),
                  AccountTopButton(
                    text: 'Wish List',
                    func: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      debugPrint(prefs.get('x-auth-token').toString());
                    },
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(' Your Orders',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'See all',
                          style: TextStyle(fontSize: 15),
                        ))
                  ],
                ),
              ),
              AccountGridView(orders: orders)
            ],
          ),
        );
      },
    );
  }
}
