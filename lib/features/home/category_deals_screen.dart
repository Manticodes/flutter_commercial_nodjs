import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/features/home/services.dart';

import '../../model/product.dart';
import 'home_widgets.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category';
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text(
                      '${snapshot.error}there is something wrong try later'));
            } else {
              if (snapshot.data == null) {
                return const Center(child: Text(' Some Thing is not ok here '));
              } else if (snapshot.data!.isEmpty) {
                return const Text('There is no product');
              } else {
                List<Product> products = snapshot.data!;
                return HomeProductScroller2(
                  products: products,
                );
              }
            }
          },
        ));
  }
}
