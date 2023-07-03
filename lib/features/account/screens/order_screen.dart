import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/features/account/services/services.dart';
import 'package:flutter_commercial_nodjs/model/order.dart';

class OrderScreen extends StatefulWidget {
  static const String routeName = "/orderScreen";
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order>? orders;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrder();
  }

  void fetchOrder() async {
    orders = await AcountService().getUserOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: orders != null
          ?
          // a gridview for the orders that shows two order in a row
          
          : Text('سفارشی یافت نشد'),
    );
  }
}
