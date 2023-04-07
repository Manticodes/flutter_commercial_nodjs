import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercial_nodjs/logic/bloc_token/token_bloc.dart';

import '../../logic/bloc_user/user_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (
        context,
        userState,
      ) {
        return BlocBuilder<TokenBloc, TokenState>(
          builder: (context, tokenState) {
            return Scaffold(
              body: Center(
                  child: Text(
                      'welcome ${userState.user.name} your token is : ${tokenState.token} ')),
            );
          },
        );
      },
    );
  }
}
