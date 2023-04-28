import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/model/product.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);
  final Product product;
  static const String routeName = '/productdetailScreen';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(),
        title: Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Icon(Icons.more_vert_outlined),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.favorite_outline),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(child: Column()),
    );
  }
}
