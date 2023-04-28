import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/features/search/widget/stars.dart';
import 'package:flutter_commercial_nodjs/model/product.dart';

import '../widgets/product_details_widget.dart';

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
        // TODO : add function to fav and more menu
        automaticallyImplyLeading: false,
        flexibleSpace: Container(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: InkWell(
                      onTap: () {},
                      child: const Icon(Icons.more_vert_outlined)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: InkWell(
                      onTap: () {}, child: const Icon(Icons.favorite_outline)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close)),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductDetailsCarousel(product: widget.product),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.product.category,
                    style: const TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  const Text(' : دسته ',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 11.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      textDirection: TextDirection.rtl,
                      overflow: TextOverflow.fade,
                      widget.product.name,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 11.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    '0 دیدگاه کاربران ',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  Stars(rating: 4)
                ],
              ),
            ),
            CostumDivider()
          ],
        ),
      ),
    );
  }
}
