import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/features/auth/widgets/costum_button.dart';
import 'package:flutter_commercial_nodjs/features/product_details/services/product_detail_services.dart';
import 'package:flutter_commercial_nodjs/features/search/widget/stars.dart';
import 'package:flutter_commercial_nodjs/model/product.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../model/user.dart';
import '../widgets/product_details_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen(
      {Key? key, required this.product, required this.user})
      : super(key: key);
  final Product product;
  final User user;
  static const String routeName = '/productdetailScreen';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  double avgStar = 0;
  double myStar = 0;
  void calculateStar() {
    if (widget.product.ratings != null) {}
    var ratingList = widget.product.ratings;
    double totalRating = 0;
    for (var i = 0; i < ratingList!.length; i++) {
      totalRating += ratingList[i].rate;
      if (widget.user.id == ratingList[i].userId) {
        print('adding rating to this user id' + widget.user.id);
        myStar = ratingList[i].rate;
      }
    }
    avgStar = totalRating / ratingList.length;
  }

  @override
  void initState() {
    calculateStar();
    super.initState();
  }

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
            const SizedBox(
              height: 7,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 11.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '0 دیدگاه کاربران ',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  Stars(rating: avgStar > 0 ? avgStar : 0)
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const CostumDivider(),
            const SizedBox(
              height: 5,
            ),
            ProductDescription(product: widget.product),
            const SizedBox(
              height: 15,
            ),
            const CostumDivider(),
            const SizedBox(
              height: 5,
            ),
            // TODO : redesign this part below and add functionallity here
            isAdded
                ? const ProductInCardWidget()
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
            const SizedBox(
              height: 20,
            ),
            const CostumDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Text(
                    'لطفا به این محصول امتیاز دهید',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 76, 75, 75)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RatingBar.builder(
                      direction: Axis.horizontal,
                      initialRating: myStar != 0 ? myStar : 3,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemBuilder: (context, index) =>
                          const Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (rating) {
                        ProductDetailServices().rateProduct(
                            context: context,
                            product: widget.product,
                            rating: rating);
                      }),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      // TODO : add functionallity here
      bottomNavigationBar: BottomAppBar(
        height: MediaQuery.of(context).size.height * 0.07,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
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
