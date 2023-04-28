// ignore_for_file: library_private_types_in_public_api

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
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Center(
                                child:
                                    Image.network(products[index].images[0])),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                color: Colors.black.withOpacity(0.5),
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  products[index].name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: CircleAvatar(
                                backgroundColor: const Color.fromARGB(32, 3, 3, 3),
                                child: IconButton(
                                    onPressed: () {
                                      AdminServices().deleteProduct(
                                          context: context,
                                          product: products[index],
                                          onSuccess: () {
                                            setState(() {});
                                          });
                                    },
                                    icon: const Icon(Icons.delete)),
                              ),
                            )
                          ],
                        ),
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
}
