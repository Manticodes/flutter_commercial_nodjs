import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        return Scaffold(
          body: Center(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
                'welcome ${userState.user.name} your token is : \n\n ${userState.user.token}'),
          )),
        );
      },
    );
  }
}
