import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercial_nodjs/constants/global_variable.dart';
import 'package:flutter_commercial_nodjs/features/search/widget/search_widgets.dart';
import 'package:flutter_commercial_nodjs/screens/home/carousel_slider.dart';
import '../../features/search/screens/search_screen.dart';
import '../../features/search/services/search_services.dart';
import '../../logic/bloc_user/user_bloc.dart';
import '../../model/product.dart';
import 'home_widgets.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// TODO : search disapear when user press back

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  void doSearch(String querry) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: querry);
  }

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (
        context,
        userState,
      ) {
        return BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 14.0, right: 12, left: 12, bottom: 12),
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                              onChanged: (String text) {
                                setState(() {
                                  isSearching = true;
                                });

                                if (searchController.text.isEmpty) {
                                  setState(() {
                                    isSearching = false;
                                  });
                                }
                              },
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus!.unfocus();
                              },
                              controller: searchController,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(),
                                label: Text('Search'),
                              )),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.keyboard_voice),
                    )
                  ],
                ),
              ),
              body: isSearching
                  ? FutureBuilder(
                      future: SearchService().getSearchProduct(
                          context: context, searchQuery: searchController.text),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
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
                            return SearchWidgets(
                              products: products,
                            );
                          }
                        }
                      },
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          AdressBar(state: state),
                          const Cataloge(),
                          const CarouselSliderImage(),
                          const DealOfDayText(),
                          HomeProductScroller(images: homeDealImageLinks)
                        ],
                      ),
                    ),
            );
          },
        );
      },
    );
  }
}
