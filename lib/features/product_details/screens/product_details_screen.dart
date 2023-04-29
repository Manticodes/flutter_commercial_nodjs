import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/features/auth/widgets/costum_button.dart';
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
  bool isAdded = false;
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
            SizedBox(
              height: 7,
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
            SizedBox(
              height: 5,
            ),
            CostumDivider(),
            SizedBox(
              height: 5,
            ),
            ProductDescription(product: widget.product),
            SizedBox(
              height: 15,
            ),
            CostumDivider(),
            SizedBox(
              height: 5,
            ),
            isAdded
                ? ProductInCardWidget()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CostumeButton(
                        title: 'افزودن به سبد خرید',
                        onTap: () {
                          setState(() {
                            isAdded = true;
                          });
                        }),
                  ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: MediaQuery.of(context).size.height * 0.07,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(' 200000 ',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Text(' : سبد خرید شما ',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Icon(
              Icons.shopping_cart_outlined,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
