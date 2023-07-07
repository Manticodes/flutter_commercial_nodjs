import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercial_nodjs/logic/bloc_user/user_bloc.dart';
import 'package:flutter_commercial_nodjs/model/product.dart';
import 'package:flutter_commercial_nodjs/features/home/category_deals_screen.dart';
import 'package:flutter_commercial_nodjs/features/home/services.dart';

import '../../constants/global_variable.dart';
import '../product_details/screens/product_details_screen.dart';
import '../search/services/search_services.dart';
import '../search/widget/search_widgets.dart';

class AdressBar extends StatelessWidget {
  final UserState state;
  const AdressBar({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: Colors.black12,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.location_on),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                ' Delivery to ${state.user.name} - ${state.user.adress}  ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.arrow_drop_down_outlined),
          )
        ],
      ),
    );
  }
}

class Cataloge extends StatelessWidget {
  const Cataloge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 90,
      child: ListView.builder(
          itemExtent: 95,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, CategoryDealsScreen.routeName,
                    arguments: categoryImageLinks[index]['text']);
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 8.0, left: 8, top: 8, bottom: 4),
                    child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 28,
                        child: Image.network(categoryImageLinks[index]['image'],
                            fit: BoxFit.cover)),
                  ),
                  Text(
                    categoryImageLinks[index]['text'],
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            );
          },
          itemCount: 4),
    );
  }
}

class SingleProductImage extends StatelessWidget {
  SingleProductImage({
    super.key,
    required this.product,
  });
  final Product product;
  final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  // ignore: prefer_function_declarations_over_variables
  final String Function(Match) mathFunc = (Match match) => '${match[1]},';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 200,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.network(
              product.images[0],
              fit: BoxFit.contain,
              height: 200,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                ),
                child: Text(
                  product.name,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${product.price.round().toString().replaceAllMapped(reg, mathFunc)}  تومان  ',
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeProductScroller2 extends StatelessWidget {
  const HomeProductScroller2({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(0, 35, 34, 34),
      height: 320,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleProductImage2(
                product: products[index],
              ),
            );
          },
          itemCount: products.length,
        ),
      ),
    );
  }
}

class SingleProductImage2 extends StatelessWidget {
  const SingleProductImage2({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: 200,
      color: Colors.transparent,
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 8, left: 8),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Image.network(
                  product.images[0],
                  fit: BoxFit.cover,
                  height: 180,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 4.0,
                ),
                child: Text(
                  product.name,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                '${product.price} تومان  ',
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DealOfDayText extends StatelessWidget {
  const DealOfDayText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 20.0,
            left: 8,
            right: 8,
          ),
          child: Text(
            'Deal Of the Day',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class DealOfTheDayWidget extends StatelessWidget {
  const DealOfTheDayWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: HomeServices().getDealsProduct(context: context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
              child:
                  Text('${snapshot.error}there is something wrong try later'));
        } else {
          if (snapshot.data == null) {
            return const Center(child: Text(' Some Thing is not ok here '));
          } else if (snapshot.data!.isEmpty) {
            return const Text('There is no product');
          } else {
            List<Product> products = snapshot.data!;
            return SizedBox(
              height: 320,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, ProductDetailsScreen.routeName,
                                arguments: [products[index], state.user]);
                          },
                          child: SingleProductImage(product: products[index]));
                    },
                  );
                },
                itemCount: 4,
              ),
            );
          }
        }
      },
    );
  }
}

class HomeScreenSearchWidget extends StatelessWidget {
  const HomeScreenSearchWidget({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SearchService().getSearchProduct(
          context: context, searchQuery: searchController.text),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
              child:
                  Text('${snapshot.error}there is something wrong try later'));
        } else {
          if (snapshot.data == null) {
            return const Center(child: Text(' Some Thing is not ok here '));
          } else if (snapshot.data!.isEmpty) {
            return const Text('There is no product');
          } else {
            List<Product> products = snapshot.data!;
            return SearchWidgets(
              products: products,
            );
          }
        }
      },
    );
  }
}
