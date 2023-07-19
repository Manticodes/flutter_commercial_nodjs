import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'package:flutter_commercial_nodjs/model/sales.dart';

class CategoryProductCharts extends StatelessWidget {
  const CategoryProductCharts({
    Key? key,
    required this.seriesList,
  }) : super(key: key);
  final List<charts.Series<Sales, String>> seriesList;

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: true,
    );
  }
}
