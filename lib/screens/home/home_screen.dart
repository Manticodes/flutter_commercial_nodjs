import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercial_nodjs/constants/global_variable.dart';
import 'package:flutter_commercial_nodjs/screens/home/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../logic/bloc_user/user_bloc.dart';
import 'home_widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  HomeScreen({super.key});

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
                                isSearching = true;
                                /*   searchList = state.allRoutines
                                        .where((element) => element.title.contains(text))
                                        .toList(); */

                                if (searchController.text.isEmpty) {
                                  isSearching = false;
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
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    AdressBar(state: state),
                    Cataloge(),
                    CarouselSliderImage(),
                    DealOfDayText(),
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
