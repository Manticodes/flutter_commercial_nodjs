import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../model/order.dart';
import '../../account/screens/order_detail_screen.dart';
import '../services/admin_services.dart';

class AdminOrderScreen extends StatefulWidget {
  const AdminOrderScreen({Key? key}) : super(key: key);
  static const String routeName = "/adminOrderScreen";

  @override
  State<AdminOrderScreen> createState() => _AdminOrderScreenState();
}

enum statusCode {
  pending,
  sending,
  sent,
  recieved,
}

class _AdminOrderScreenState extends State<AdminOrderScreen> {
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
    orders = await AdminServices().getAllOrders(context: context);
    setState(() {});
  }

  String orderStatus(Order order) {
    switch (order.status) {
      case 0:
        return 'در حال پردازش';
      case 1:
        return 'انتظار ارسال';
      case 2:
        return 'ارسال شده';
      case 3:
        return 'تحویل شده';
      default:
        return 'نا مشخص';
    }
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
                      height: 140,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text('data'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Text(
                                    d24,
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 136, 136, 136)),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, OrderDetailScreen.route,
                                            arguments: orders![index]);
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(Icons.arrow_left),
                                      ),
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
                                                height: 50,
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
                                                height: 50,
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
                                                height: 50,
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
                                              height: 50,
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
