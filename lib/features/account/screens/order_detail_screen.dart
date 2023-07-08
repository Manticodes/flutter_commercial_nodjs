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
          children: [OrderProductList(order: order)],
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
