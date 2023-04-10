import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/features/admin/screens/post_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List pages = [
    const PostScreen(),
    const Center(
      child: Text('kart'),
    ),
    const Center(
      child: Text('kart'),
    )
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
              Text(
                'Admin Panel',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
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
            label: 'Home',
            icon: Container(
              width: 42,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _pageIndex == 0
                              ? Color.fromARGB(255, 248, 90, 90)
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
                              ? Color.fromARGB(255, 248, 90, 90)
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
                              ? Color.fromARGB(255, 248, 90, 90)
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
