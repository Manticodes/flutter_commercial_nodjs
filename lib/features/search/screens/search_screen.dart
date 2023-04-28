import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/features/search/services/search_services.dart';

import '../../../model/product.dart';
import '../../../screens/home/home_widgets.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/searchRoute';
  final String searchQuerry;
  const SearchScreen({Key? key, required this.searchQuerry}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
              Row(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Result for ${widget.searchQuerry}'),
                ),
              ])
            ],
          ),
        ),
        body: FutureBuilder(
          future: SearchService().getSearchProduct(
              context: context, searchQuery: widget.searchQuerry),
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
                return const Center(child: Text(' Some Thing is not ok here '));
              } else if (snapshot.data!.isEmpty) {
                return const Text('There is no product');
              } else {
                List<Product> products = snapshot.data!;
                return HomeProductScroller2(
                  products: products,
                );
              }
            }
          },
        ));
  }
}
