import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/model/product.dart';

import '../../../logic/bloc_user/user_bloc.dart';

class CartList extends StatelessWidget {
  const CartList({Key? key, required this.state}) : super(key: key);
  final UserState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Column(
            children: state.user.cart.map((e) {
              Product product = Product.fromMap(e['product']);
              int quantity = e['quantity'];
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Column(
                          children: [Text(product.name)],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Image.network(
                        product.images[0],
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.3,
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
            }).toList(),
          ),
        ],
      ),
    );
  }
}
