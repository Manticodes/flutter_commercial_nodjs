import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercial_nodjs/features/account/screens/account_screen.dart';
import 'package:flutter_commercial_nodjs/features/cart/screen/cart._screen.dart';
import 'package:flutter_commercial_nodjs/features/home/home_screen.dart';

import '../../logic/bloc_user/user_bloc.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});
  static const route = "TabScreen";

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List pages = [
    const HomeScreen(),
    AccountScreen(),
    // CartScreen(),
    ShoppingCartPage()
  ];
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Container(
              width: 42,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _pageIndex == 0
                              ? const Color.fromARGB(255, 248, 90, 90)
                              : Colors.white,
                          width: 5))),
              child: const Icon(Icons.home_outlined),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Acount',
            icon: Container(
              width: 42,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _pageIndex == 1
                              ? const Color.fromARGB(255, 248, 90, 90)
                              : Colors.white,
                          width: 5))),
              child: const Icon(Icons.person_outline_outlined),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Home',
            icon: Container(
              width: 42,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _pageIndex == 2
                              ? const Color.fromARGB(255, 248, 90, 90)
                              : Colors.white,
                          width: 5))),
              child: badges.Badge(
                  stackFit: StackFit.passthrough,
                  badgeStyle: const badges.BadgeStyle(
                      badgeColor: Color.fromARGB(83, 255, 255, 255)),
                  badgeContent: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      return Text(state.user.cart.length.toString());
                    },
                  ),
                  child: const Icon(Icons.shop_2_outlined)),
            ),
          ),
        ],
      ),
    );
  }
}
