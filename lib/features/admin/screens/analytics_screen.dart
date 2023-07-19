import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/features/admin/services/admin_services.dart';

import '../../../model/sales.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int? totalsales;
  List<Sales>? saleList;
  void getEarnings() async {
    var earningData = await AdminServices().getEarnings(context);
    totalsales = earningData['totalEarnings'];
    saleList = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return saleList == null || totalsales == null
        ? const CircularProgressIndicator()
        : Column(
            children: [
              Text(
                '\$$totalsales',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          );
  }
}
