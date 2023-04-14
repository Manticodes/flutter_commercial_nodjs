import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercial_nodjs/features/account/widgets/consumable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../logic/bloc_user/user_bloc.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);
  final List images = [
    'https://dkstatics-public.digikala.com/digikala-adservice-banners/890322f7df7dee11dbf2a287e24ec96704bc9855_1680594701.jpg?x-oss-process=image/quality,q_95/format,webp',
    'https://dkstatics-public.digikala.com/digikala-adservice-banners/9ee9d49fb91c875ca390d29d45decd25d7d1097b_1679745917.jpg?x-oss-process=image/quality,q_95/format,webp',
    'https://dkstatics-public.digikala.com/digikala-adservice-banners/d20b7a098d299033bb150d6cb5d120edfdbbb862_1678186404.jpg?x-oss-process=image/quality,q_95/format,webp',
    'https://dkstatics-public.digikala.com/digikala-adservice-banners/66365cc079fbe146271a57bbfc0d12f65fd5dd36_1673776059.jpg?x-oss-process=image/quality,q_95/format,webp'
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
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
                  Row(children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.notifications),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.search),
                    )
                  ])
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Text('Welcome ${state.user.name.toUpperCase()}',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AccountTopButton(
                    text: 'Orders',
                    func: () {},
                  ),
                  AccountTopButton(
                    text: 'Seller',
                    func: () {
                      debugPrint(state.user.type);
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AccountTopButton(
                    text: 'Log Out',
                    func: () async {
                      context.read<UserBloc>().add(CleanUser());
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.clear();
                      debugPrint(prefs.get('x-auth-token').toString());
                    },
                  ),
                  AccountTopButton(
                    text: 'Wish List',
                    func: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      debugPrint(prefs.get('x-auth-token').toString());
                    },
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(' Your Orders',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'See all',
                          style: TextStyle(fontSize: 15),
                        ))
                  ],
                ),
              ),
              ProductScroller(images: images)
            ],
          ),
        );
      },
    );
  }
}
