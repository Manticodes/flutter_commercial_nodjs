import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/features/account/services/services.dart';
import 'package:flutter_commercial_nodjs/model/order.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
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
    return orders != null
        ? ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                child: Text(orders![index].id),
              );
            },
          )
        : Text('سفارشی یافت نشد');
  }
}
