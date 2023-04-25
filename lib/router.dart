import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/features/admin/screens/add_product_screen.dart';
import 'package:flutter_commercial_nodjs/features/admin/screens/admin_screen.dart';
import 'package:flutter_commercial_nodjs/features/auth/screens/auth_screen.dart';
import 'package:flutter_commercial_nodjs/features/search/screens/search_screen.dart';
import 'package:flutter_commercial_nodjs/main.dart';
import 'package:flutter_commercial_nodjs/screens/home/category_deals_screen.dart';
import 'package:flutter_commercial_nodjs/screens/home/home_screen.dart';
import 'package:flutter_commercial_nodjs/screens/home/tab_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const AuthScreen(), settings: routeSettings);
    case HomeScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => HomeScreen(), settings: routeSettings);
    case TabScreen.route:
      return MaterialPageRoute(
          builder: (context) => const TabScreen(), settings: routeSettings);
    case MyApp.routename:
      return MaterialPageRoute(
          builder: (context) => const MyApp(), settings: routeSettings);
    case AdminScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const AdminScreen(), settings: routeSettings);
    case AddProductScreen.royteName:
      return MaterialPageRoute(
          builder: (context) => const AddProductScreen(),
          settings: routeSettings);
    case CategoryDealsScreen.routeName:
      return MaterialPageRoute(
          builder: (context) =>
              CategoryDealsScreen(category: routeSettings.arguments.toString()),
          settings: routeSettings);
    case SearchScreen.routeName:
      return MaterialPageRoute(
        builder: (context) =>
            SearchScreen(searchQuerry: routeSettings.arguments.toString()),
        settings: routeSettings,
      );
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(child: Text('Screen not exist')),
              ));
  }
}
