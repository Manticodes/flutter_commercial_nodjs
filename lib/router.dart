import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/features/auth/screens/auth_screen.dart';
import 'package:flutter_commercial_nodjs/screens/home/home_screen.dart';
import 'package:flutter_commercial_nodjs/screens/home/tab_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const AuthScreen(), settings: routeSettings);
    case HomeScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const HomeScreen(), settings: routeSettings);
    case TabScreen.route:
      return MaterialPageRoute(
          builder: (context) => const TabScreen(), settings: routeSettings);
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(child: Text('Screen not exist')),
              ));
  }
}
