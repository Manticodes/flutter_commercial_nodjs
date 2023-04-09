import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercial_nodjs/features/auth/screens/auth_screen.dart';
import 'package:flutter_commercial_nodjs/features/auth/services/auth_server.dart';
import 'package:flutter_commercial_nodjs/router.dart';
import 'package:flutter_commercial_nodjs/screens/home/tab_screen.dart';
import 'logic/bloc_user/user_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => UserBloc(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    AuthService().getUserData(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              useMaterial3: true,
              colorScheme: const ColorScheme.light(
                  primary: Color.fromARGB(255, 239, 80, 62))),
          darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: const ColorScheme.dark(
                  primary: Color.fromARGB(255, 239, 80, 62))),
          themeMode: ThemeMode.light,
          onGenerateRoute: (settings) => generateRoute(settings),
          home: userState.user.token.isNotEmpty
              ? const TabScreen()
              : const AuthScreen(),
        );
      },
    );
  }
}
