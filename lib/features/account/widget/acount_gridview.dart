import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercial_nodjs/features/account/screens/order_detail_screen.dart';
import 'package:flutter_commercial_nodjs/model/order.dart';
import 'dart:math';
import '../../../logic/bloc_user/user_bloc.dart';

class AccountGridView extends StatelessWidget {
  const AccountGridView(
      {Key? key, required this.orders, required this.showmore})
      : super(key: key);
  final List<Order>? orders;
  final bool showmore;

  int getRandomNumber(int range) {
    Random random = Random();
    int randomNumber = random.nextInt(range);
    return randomNumber;
  }

  String getLastFiveCharacters(String input) {
    if (input.length <= 5) {
      return input;
    } else {
      return input.substring(input.length - 5);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (orders == null) {
      return const Text('شما هیچ سفارش فعالی ندارید');
    } else {
      return Expanded(
        child: GridView.builder(
          itemCount: showmore == false
              ? orders!.length > 1
                  ? 2
                  : orders!.length
              : orders!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.6),
          itemBuilder: (context, index) {
            int productsLenght = orders![index].products.length;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, OrderDetailScreen.route,
                          arguments: orders![index]);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        color: const Color.fromARGB(172, 228, 227, 227),
                        height: 400,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 12),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    orders![index]
                                        .products[
                                            getRandomNumber(productsLenght)]
                                        .images[0],
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Text.rich(
                                              TextSpan(children: [
                                                TextSpan(
                                                  text: getLastFiveCharacters(
                                                      orders![index].id),
                                                ),
                                                const TextSpan(text: ' : '),
                                                const TextSpan(
                                                    text: 'کد مرسوله')
                                              ]),
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Text.rich(
                                            TextSpan(
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
                                                    overflow: TextOverflow.fade,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                const WidgetSpan(
                                                    child: Text(
                                                  '  تومان',
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ))
                                              ],
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.fade,
                                            textAlign: TextAlign.right,
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, top: 5),
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                const WidgetSpan(
                                                    child: Text(
                                                  'محصول در این سبد ',
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                )),
                                                WidgetSpan(
                                                  child: Text(
                                                    orders![index]
                                                        .products
                                                        .length
                                                        .toString(),
                                                    overflow: TextOverflow.fade,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textAlign: TextAlign.right,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                  ),
                                                )
                                              ],
                                            ),
                                            textAlign: TextAlign.right,
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ),
                                      ]),
                                )
                              ]),
                        ),
                      ),
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
