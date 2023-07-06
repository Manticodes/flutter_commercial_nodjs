import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercial_nodjs/features/product_details/screens/product_details_screen.dart';
import 'package:flutter_commercial_nodjs/features/search/widget/stars.dart';
import 'package:flutter_commercial_nodjs/model/order.dart';
import 'package:flutter_commercial_nodjs/model/product.dart';
import 'dart:math';
import '../../../logic/bloc_user/user_bloc.dart';

class AccountGridView extends StatelessWidget {
  const AccountGridView({Key? key, required this.orders}) : super(key: key);
  final List<Order>? orders;

  int getRandomNumber(int range) {
    Random random = Random();
    int randomNumber = random.nextInt(range);
    return randomNumber;
  }

  @override
  Widget build(BuildContext context) {
    if (orders == null) {
      return Text('هیچ محصولی یافت نشد');
    } else {
      return Expanded(
        child: GridView.builder(
          itemCount: orders!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            int productsLenght = orders![index].products.length;
            Product product =
                orders![index].products[getRandomNumber(productsLenght)];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  return InkWell(
                    onTap:
                        () => /* Navigator.pushNamed(
                      context, ProductDetailsScreen.routeName,
                      arguments: [product, state.user]) */
                            () {},
                    child: SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                orders![index]
                                    .products[getRandomNumber(productsLenght)]
                                    .images[0],
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Flexible(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, top: 5),
                                      child: Text(
                                        product.name,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 5),
                                      child: Text.rich(TextSpan(
                                        children: [
                                          const WidgetSpan(
                                              child: Icon(
                                            Icons.attach_money_outlined,
                                            size: 20,
                                            color: Colors.green,
                                          )),
                                          WidgetSpan(
                                            child: Text(
                                              orders![index]
                                                  .totalPrice
                                                  .round()
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const WidgetSpan(
                                              child: Text(
                                            '  تومان',
                                            style: TextStyle(fontSize: 15),
                                          ))
                                        ],
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, top: 5),
                                      child: Text(
                                        '$productsLenght محصول در این صبد ',
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ]),
                            )
                          ]),
                    ),
                  );
                },
              ),
            );
          },
        ),
      );
    }
  }
}
