import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/features/admin/screens/add_product_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('texr')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addPost();
        },
        child: Icon(Icons.add),
        tooltip: 'Add Your Product',
      ),
    );
  }

  void _addPost() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(child: AddProductScreen());
      },
    );
  }
}
