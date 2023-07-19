// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercial_nodjs/features/admin/screens/admin_order_screen.dart';
import 'package:flutter_commercial_nodjs/features/admin/screens/analytics_screen.dart';
import 'package:flutter_commercial_nodjs/features/admin/screens/post_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../logic/bloc_user/user_bloc.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);
  static const String routeName = 'AdminScreen';

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List pages = [
    const PostScreen(),
    const AdminOrderScreen(),
    const AnalyticsScreen()
  ];
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'lib/assets/images/logo.png',
                ),
              ),
              Row(
                children: [
                  const Text(
                    'Admin Panel',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () async {
                        context.read<UserBloc>().add(CleanUser());
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.clear();
                        debugPrint(prefs.get('x-auth-token').toString());
                      },
                      icon: const Icon(Icons.logout_outlined))
                ],
              ),
            ],
          ),
        ),
      ),
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
            label: 'افزودن',
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
            label: 'سفارشات',
            icon: Container(
              width: 42,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _pageIndex == 1
                              ? const Color.fromARGB(255, 248, 90, 90)
                              : Colors.white,
                          width: 5))),
              child: const Icon(Icons.analytics_outlined),
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
              child: const Icon(Icons.inbox_outlined),
            ),
          )
        ],
      ),
    );
  }
}
