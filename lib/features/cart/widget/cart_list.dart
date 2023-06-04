import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/features/cart/services/services.dart';
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
  List<bool> validproduct = [];
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
                future: CartServices()
                    .checkItemValidation(id: product.id.toString()),
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
                      return const Center(
                          child: Text(' Some Thing is not ok here '));
                    } else {
                      validproduct.add(snapshot.data as bool);
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
                                    SizedBox(
                                      height: 3,
                                    ),
                                    if (snapshot.data == false)
                                      Text('پایان موجودی در انبار '),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(product.name,
                                        textAlign: TextAlign.right,
                                        softWrap: true,
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 5),
                                      child: Text.rich(
                                          textAlign: TextAlign.right,
                                          TextSpan(
                                            children: [
                                              const WidgetSpan(
                                                  child: Icon(
                                                Icons.attach_money_outlined,
                                                size: 20,
                                                color: Colors.green,
                                              )),
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
                                    SizedBox(
                                      height: 5,
                                    ),
                                    if (snapshot.data == true)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: 35,
                                            height: 35,
                                            child: Card(
                                              child: Icon(Icons.add,
                                                  color: Colors.red),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '${product.quantity.round()}',
                                            overflow: TextOverflow.clip,
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            width: 35,
                                            height: 35,
                                            child: Card(
                                              child: Icon(Icons.remove,
                                                  color: Colors.red),
                                            ),
                                          )
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Opacity(
                                opacity: snapshot.data == false ? 0.1 : 1,
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
