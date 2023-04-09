import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../logic/bloc_user/user_bloc.dart';

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
        return Scaffold(
          appBar: AppBar(
            title: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        height: 50,
                        child: Material(
                          elevation: 1,
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.keyboard_voice),
                  )
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              Container(
                height: 40,
              )
            ],
          ),
        );
      },
    );
  }
}
