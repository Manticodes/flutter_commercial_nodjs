import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/screens/home/services.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = 'category';
  const CategoryDealsScreen({Key? key, required this.category})
      : super(key: key);
  final String category;

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'lib/assets/images/logo.png',
                ),
              ),
              Row(
                children: [
                  Text(
                    widget.category,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: FutureBuilder(
          future: HomeServices()
              .getcategoryProduct(context: context, category: widget.category),
          builder: (context, snapshot) {
            return DecoratedBox(decoration: BoxDecoration(color: Colors.amber));
          },
        ));
  }
}
