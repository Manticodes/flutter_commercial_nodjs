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
                  child: Container(
                    color: const Color.fromARGB(133, 246, 246, 246),
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
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 136, 136, 136)),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(Icons.arrow_left),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        if (orders![index].products.length > 4)
                                          Text(
                                              '${(orders![index].products.length - 4)} + '),
                                        if (orders![index].products.length > 3)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              child: SizedBox(
                                                width: 60,
                                                height: 40,
                                                child: Image.network(
                                                    orders![index]
                                                        .products[3]
                                                        .images[0],
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                          ),
                                        if (orders![index].products.length > 2)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              child: SizedBox(
                                                width: 60,
                                                height: 40,
                                                child: Image.network(
                                                    orders![index]
                                                        .products[2]
                                                        .images[0],
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                          ),
                                        if (orders![index].products.length > 1)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              child: SizedBox(
                                                width: 60,
                                                height: 40,
                                                child: Image.network(
                                                    orders![index]
                                                        .products[1]
                                                        .images[0],
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                          ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: SizedBox(
                                              width: 60,
                                              height: 40,
                                              child: Image.network(
                                                  orders![index]
                                                      .products[0]
                                                      .images[0],
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
