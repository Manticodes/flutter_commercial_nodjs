import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/bloc_user/user_bloc.dart';

class CatSubTotal extends StatelessWidget {
  const CatSubTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        List cart = state.user.cart;
        return Container(
          child: Row(children: [const Text('data')]),
        );
      },
    );
  }
}
