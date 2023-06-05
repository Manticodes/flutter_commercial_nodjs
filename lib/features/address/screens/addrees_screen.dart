import 'package:flutter/material.dart';

class AddreesScreen extends StatefulWidget {
  const AddreesScreen({Key? key}) : super(key: key);

  @override
  _AddreesScreenState createState() => _AddreesScreenState();
}

class _AddreesScreenState extends State<AddreesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            Row(children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.notifications),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.search),
              )
            ])
          ],
        ),
      ),
    );
  }
}
