import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/features/account/widget/order_product_list.dart';

import '../../../model/order.dart';

class OrderDetailScreen extends StatelessWidget {
  OrderDetailScreen({
    Key? key,
    required this.order,
  }) : super(key: key);
  final Order order;
  static const String route = "/orderDetails";
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]},';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            OrderProductList(order: order),
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: Container(
                height: 100,
                width: double.infinity,
                color: const Color.fromARGB(255, 226, 225, 225),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [Text(' : ارسال به '), Text(order.address)],
                  ),
                ),
              ),
            ),
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
                Text.rich(TextSpan(
                    children: [
                      TextSpan(text: ' جمع کل'),
                    ],
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                Text(
                    ' ${order.totalPrice.round().toString().replaceAllMapped(reg, mathFunc)} ')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
