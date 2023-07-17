import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercial_nodjs/features/account/widget/order_product_list.dart';
import 'package:flutter_commercial_nodjs/features/admin/services/admin_services.dart';
import 'package:flutter_commercial_nodjs/features/auth/widgets/costum_button.dart';
import 'package:intl/intl.dart';

import '../../../logic/bloc_user/user_bloc.dart';
import '../../../model/order.dart';

class OrderDetailScreen extends StatefulWidget {
  OrderDetailScreen({
    Key? key,
    required this.order,
  }) : super(key: key);
  final Order order;
  static const String route = "/orderDetails";

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int currenStep = 0;
  final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');

  // ignore: prefer_function_declarations_over_variables
  final String Function(Match) mathFunc = (Match match) => '${match[1]},';
  @override
  void initState() {
    super.initState();
    currenStep = widget.order.status;
  }

  void changeOrderStatus(
    int status,
  ) {
    AdminServices().changeOrderStatus(
        context: context,
        status: status + 1,
        order: widget.order,
        onSuccess: () {
          setState(() {
            currenStep += 1;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt);
    var date24 = DateFormat('dd/MM/yyyy').format(date);
    return Scaffold(
      appBar: AppBar(
        title: const Text('جزئیات سفارش'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            OrderProductList(order: widget.order),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: double.infinity,
                  color: const Color.fromARGB(255, 226, 225, 225),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(' : ارسال به ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        Center(
                          child: Text(widget.order.address,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return Stepper(
                  currentStep: currenStep,
                  steps: [
                    Step(
                        title: const Text('در حال پردازش'),
                        content: const Text(
                            'سفارش شما در حال پردازش می باشد لطفا شکیبا باشید',
                            textAlign: TextAlign.right),
                        isActive: currenStep >= 0,
                        state: currenStep > 0
                            ? StepState.complete
                            : StepState.indexed),
                    Step(
                        title: const Text('در حال ارسال'),
                        content: const Text(
                            'سفارش شما پردازش شده است و در صف انتظار ارسال می باشد',
                            textAlign: TextAlign.right),
                        isActive: currenStep > 0,
                        state: currenStep > 1
                            ? StepState.complete
                            : StepState.indexed),
                    Step(
                        title: const Text('ارسال شده'),
                        content: const Text(
                            'سفارش شما ارسال شده است و بزودی به دست شما می رسد',
                            textAlign: TextAlign.right),
                        isActive: currenStep > 1,
                        state: currenStep > 2
                            ? StepState.complete
                            : StepState.indexed),
                    Step(
                      title: const Text('تحویل داده شده'),
                      content: const Text('سفارش شما با موفقیت تحویل داده شد',
                          textAlign: TextAlign.right),
                      isActive: currenStep > 2,
                      state: currenStep > 2
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                  ],
                  controlsBuilder: (context, details) {
                    if (state.user.type == 'admin' && details.currentStep < 3) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: CostumeButton(
                          title: 'قدم بعدی',
                          onTap: () => changeOrderStatus(details.currentStep),
                          color1: Colors.blue,
                        ),
                      );
                    }
                    return const SizedBox(
                      width: double.infinity,
                    );
                  },
                );
              },
            )
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
                const Text.rich(TextSpan(
                    children: [
                      TextSpan(text: 'تاریخ ارسال'),
                    ],
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                Text(date24)
              ],
            ),
            Column(
              children: [
                const Text.rich(TextSpan(
                    children: [
                      TextSpan(text: ' جمع کل'),
                    ],
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                Text(
                    ' ${widget.order.totalPrice.round().toString().replaceAllMapped(reg, mathFunc)} ')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
