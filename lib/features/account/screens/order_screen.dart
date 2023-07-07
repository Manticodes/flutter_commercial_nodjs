import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/features/account/services/services.dart';
import 'package:flutter_commercial_nodjs/model/order.dart';

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
                return Card(
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text('data'), Text('data')],
                            ),
                          ),
                          Text('data')
                        ]),
                  ),
                );
              },
              itemCount: orders!.length,
            )
          : const Center(child: Text('سفارشی یافت نشد')),
    );
  }
}
