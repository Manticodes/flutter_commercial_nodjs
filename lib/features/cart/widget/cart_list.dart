import 'package:flutter/material.dart';

import '../../../logic/bloc_user/user_bloc.dart';

class CartList extends StatelessWidget {
  const CartList({Key? key, required this.state}) : super(key: key);
  final UserState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromARGB(83, 197, 194, 194)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: state.user.cart.map((e) {
            return Text('a');
          }).toList(),
        ),
      ),
    );
  }
}
