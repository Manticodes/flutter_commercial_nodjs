import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercial_nodjs/features/auth/widgets/costum_button.dart';
import 'package:flutter_commercial_nodjs/features/product_details/services/product_detail_services.dart';
import 'package:flutter_commercial_nodjs/features/search/widget/stars.dart';
import 'package:flutter_commercial_nodjs/model/product.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../logic/bloc_user/user_bloc.dart';
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
                  const Text(
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
            //TODO : add more validation and condition here like if user cart is more than stock or product is out of stock
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                Product product = Product(
                    name: '',
                    description: '',
                    quantity: 0,
                    images: [],
                    category: '',
                    price: 0);
                User user = state.user;
                bool productExist = false;
                int userQuantity = 0;

                for (var i = 0; i < user.cart.length; i++) {
                  Product theProduct = Product.fromMap(user.cart[i]['product']);

                  if (theProduct.id == widget.product.id) {
                    productExist = true;
                    product = theProduct;
                    userQuantity = user.cart[i]['quantity'];

                    break;
                  }
                }

                return productExist
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  if (userQuantity < widget.product.quantity) {
                                    ProductDetailServices().addToCart(
                                        context: context, product: product);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text('حداکثر موجودی'),
                                      duration: Duration(milliseconds: 800),
                                    ));
                                  }
                                });
                              },
                              child: const Card(
                                child: Icon(Icons.add, color: Colors.red),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            userQuantity.round().toString(),
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  ProductDetailServices().minusCart(
                                      context: context, product: product);
                                });
                              },
                              child: Card(
                                child: userQuantity == 1
                                    ? const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )
                                    : const Icon(Icons.remove,
                                        color: Colors.red),
                              ),
                            ),
                          )
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CostumeButton(
                            title: 'افزودن به سبد خرید',
                            onTap: () {
                              setState(() {
                                isAdded = true;
                                ProductDetailServices().addToCart(
                                    context: context, product: widget.product);
                              });
                            }),
                      );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const CostumDivider(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
        child: const Row(
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
