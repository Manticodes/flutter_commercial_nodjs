import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercial_nodjs/features/admin/screens/add_product_screen.dart';
import 'package:flutter_commercial_nodjs/features/admin/services/admin_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../logic/bloc_user/user_bloc.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          body: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: const CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString() + 'hahah'));
              } else {
                if (snapshot.data == null) {
                  return Center(
                      child: const Text(' Some Thing is not ok here '));
                } else if (snapshot.data!.isEmpty) {
                  return Text('There is no product');
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Text(snapshot.data![index].name);
                    },
                    itemCount: snapshot.data!.length,
                  );
                }
              }
            },
            future: AdminServices().getProduct(context),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _addPost();
            },
            tooltip: 'Add Your Product',
            child: const Icon(Icons.add),
          ),
        );
      },
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
