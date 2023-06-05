import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/features/cart/services/services.dart';
import 'package:flutter_commercial_nodjs/features/product_details/services/product_detail_services.dart';
import 'package:flutter_commercial_nodjs/model/product.dart';

import '../../../logic/bloc_user/user_bloc.dart';
import '../../search/widget/stars.dart';

class CartList extends StatefulWidget {
  const CartList({Key? key, required this.state}) : super(key: key);
  final UserState state;

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Column(
            children: widget.state.user.cart.map((e) {
              Product product = Product.fromMap(e['product']);

              int quantity = e['quantity'];
              double avgStar = 0;

              if (product.ratings != null) {}
              var ratingList = product.ratings;
              double totalRating = 0;
              for (var i = 0; i < ratingList!.length; i++) {
                totalRating += ratingList[i].rate;
              }
              if (totalRating != 0) {
                avgStar = totalRating / ratingList.length;
              }

              return FutureBuilder(
                future: Future.wait([
                  CartServices().checkItemValidation(id: product.id.toString()),
                  ProductDetailServices()
                      .getOneProduct(context: context, product: product)
                ]),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                            '${snapshot.error}there is something wrong try later'));
                  } else {
                    if (snapshot.data == null) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      Product orginalProduct = snapshot.data![1];
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    if (snapshot.data![0] == false)
                                      const Text('این محصول حذف شده است')
                                    else if (orginalProduct.quantity == 0)
                                      const Text('موجودی انبار تمام شده است'),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(product.name,
                                        textAlign: TextAlign.right,
                                        softWrap: true,
                                        textDirection: TextDirection.rtl,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 5),
                                      child: Text.rich(
                                          textAlign: TextAlign.right,
                                          TextSpan(
                                            children: [
                                              WidgetSpan(
                                                child: Text(
                                                  product.price
                                                      .round()
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              const WidgetSpan(
                                                  child: Text(
                                                '  تومان',
                                                style: TextStyle(fontSize: 15),
                                              ))
                                            ],
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, top: 5),
                                      child: Text(
                                        '${product.category} : دسته ',
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 14.0, top: 5),
                                      child: Stars(
                                        rating: avgStar,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    snapshot.data![0] == true
                                        ? quantity > orginalProduct.quantity
                                            ? Column(
                                                children: [
                                                  const Text(
                                                    'کاهش موجودی انبار لطفا تعداد این محصول را کاهش دهید',
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    textAlign: TextAlign.right,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(quantity.toString()),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                        height: 35,
                                                        child: InkWell(
                                                          onTap: () {
                                                            ProductDetailServices()
                                                                .minusCart(
                                                                    context:
                                                                        context,
                                                                    product:
                                                                        product);
                                                          },
                                                          child: Card(
                                                            child: quantity == 1
                                                                ? const Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: Colors
                                                                        .red,
                                                                  )
                                                                : const Icon(
                                                                    Icons
                                                                        .remove,
                                                                    color: Colors
                                                                        .red),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    width: 35,
                                                    height: 35,
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          if (quantity !=
                                                              null) {
                                                            ProductDetailServices()
                                                                .addToCart(
                                                                    context:
                                                                        context,
                                                                    product:
                                                                        product);
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                              content: Text(
                                                                  'حداکثر موجودی'),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      800),
                                                            ));
                                                          }
                                                        });
                                                      },
                                                      child: const Card(
                                                        child: Icon(Icons.add,
                                                            color: Colors.red),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    '$quantity',
                                                    overflow: TextOverflow.clip,
                                                    textAlign: TextAlign.right,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  SizedBox(
                                                    width: 35,
                                                    height: 35,
                                                    child: InkWell(
                                                      onTap: () {
                                                        ProductDetailServices()
                                                            .minusCart(
                                                                context:
                                                                    context,
                                                                product:
                                                                    product);
                                                      },
                                                      child: Card(
                                                        child: quantity == 1
                                                            ? const Icon(
                                                                Icons.delete,
                                                                color:
                                                                    Colors.red,
                                                              )
                                                            : const Icon(
                                                                Icons.remove,
                                                                color:
                                                                    Colors.red),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                        //TODO: add functionality
                                        : InkWell(
                                            onTap: () {},
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: const [
                                                Text('حذف محصول'),
                                                Icon(Icons.close),
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Opacity(
                                opacity: snapshot.data![0] == false ||
                                        product.quantity == 0
                                    ? 0.1
                                    : 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    product.images[0],
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Divider(
                              color: Color.fromARGB(190, 138, 143, 146),
                            ),
                          )
                        ],
                      );
                    }
                  }
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
