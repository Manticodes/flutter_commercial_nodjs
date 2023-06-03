import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/features/cart/services/services.dart';
import 'package:flutter_commercial_nodjs/model/product.dart';

import '../../../logic/bloc_user/user_bloc.dart';

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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Column(
                                  children: [
                                    Text(product.name,
                                        softWrap: true,
                                        textDirection: TextDirection.rtl),
                                    Text(snapshot.data.toString())
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                              ),
                              Opacity(
                                opacity: snapshot.data == false ? 0.1 : 1,
                                child: Image.network(
                                  product.images[0],
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
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
