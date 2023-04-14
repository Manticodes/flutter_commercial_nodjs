import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercial_nodjs/features/admin/screens/add_product_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../logic/bloc_user/user_bloc.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          body: InkWell(
              onTap: () async {
                context.read<UserBloc>().add(CleanUser());
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.clear();
              },
              child: const InkWell(child: Center(child: Text('texr')))),
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
