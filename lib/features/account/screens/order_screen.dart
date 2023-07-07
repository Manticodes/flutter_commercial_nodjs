import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/features/account/services/services.dart';
import 'package:flutter_commercial_nodjs/model/order.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatefulWidget {
  static const String routeName = "/orderScreen";
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order>? orders;

  @override
  void initState() {
    super.initState();
    fetchOrder();
  }

  String getLastFiveCharacters(String input) {
    if (input.length <= 5) {
      return input;
    } else {
      return input.substring(input.length - 5);
    }
  }

  void fetchOrder() async {
    orders = await AccountService().getUserOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: orders != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                var date = DateTime.fromMillisecondsSinceEpoch(
                    orders![index].orderedAt);
                var d24 = DateFormat('dd/MM/yyyy').format(date);
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                  child: Card(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Text('تومان '),
                                      Text(
                                          orders![index].totalPrice.toString()),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(getLastFiveCharacters(
                                          orders![index].id)),
                                      const Text(
                                        ' : کد سفارش',
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Text(
                                d24,
                                style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 136, 136, 136)),
                              ),
                            )
                          ]),
                    ),
                  ),
                );
              },
              itemCount: orders!.length,
            )
          : const Center(child: Text('سفارشی یافت نشد')),
    );
  }
}
