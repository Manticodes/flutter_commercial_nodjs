import 'package:charts_flutter_new/flutter.dart' as chart;
import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/features/admin/services/admin_services.dart';
import 'package:flutter_commercial_nodjs/features/admin/widgets/category_product_charts.dart';

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
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    getEarnings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return saleList == null || totalsales == null
        ? Center(child: const CircularProgressIndicator())
        : Column(
            children: [
              Text(
                '\$$totalsales',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 250,
                child: CategoryProductCharts(seriesList: [
                  chart.Series(
                    id: 'sales',
                    data: saleList!,
                    //x axis
                    domainFn: (Sales sale, _) => sale.label,
                    //y axis
                    measureFn: (Sales sale, _) => sale.earning,
                  )
                ]),
              )
            ],
          );
  }
}
