import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercial_nodjs/features/admin/screens/add_product_screen.dart';
import 'package:flutter_commercial_nodjs/features/admin/services/admin_services.dart';
import 'package:flutter_commercial_nodjs/model/product.dart';

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
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                        '${snapshot.error}there is something wrong try later'));
              } else {
                if (snapshot.data == null) {
                  return const Center(
                      child: Text(' Some Thing is not ok here '));
                } else if (snapshot.data!.isEmpty) {
                  return const Text('There is no product');
                } else {
                  List<Product> products = snapshot.data!;
                  return GridView.builder(
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 150,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 8, left: 8),
                              child: Image.network(
                                products[index].images[0],
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Text(products[index].name),
                          Text(products[index].description)
                        ],
                      );
                    },
                  );
                }
              }
            },
            future: AdminServices().getProduct(context),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AddProductScreen.royteName);
            },
            tooltip: 'Add Your Product',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  /* void _addPost() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(child: AddProductScreen());
      },
    );
  } */
}
