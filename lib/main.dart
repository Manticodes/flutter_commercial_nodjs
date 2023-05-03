import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercial_nodjs/features/admin/screens/admin_screen.dart';
import 'package:flutter_commercial_nodjs/features/auth/screens/auth_screen.dart';
import 'package:flutter_commercial_nodjs/features/auth/services/auth_server.dart';
import 'package:flutter_commercial_nodjs/router.dart';
import 'package:flutter_commercial_nodjs/screens/home/loading.dart';
import 'package:flutter_commercial_nodjs/screens/home/tab_screen.dart';
import 'logic/bloc_user/user_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => UserBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  static const String routename = '/MyApp';
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loaded = false;
  @override
  void initState() {
    AuthService().getUserData(context: context).whenComplete(() {
      setState(() {
        loaded = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        debugPrint(
            ' ${userState.user.id}  has data ? ${userState.user.token} ');
        return MaterialApp(
            debugShowCheckedModeBanner: false,
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
            home: loaded == false
                ? const Loading()
                : userState.user.token.isNotEmpty
                    ? userState.user.type == 'admin'
                        ? const AdminScreen()
                        : const TabScreen()
                    : const AuthScreen());
      },
    );
  }
}
