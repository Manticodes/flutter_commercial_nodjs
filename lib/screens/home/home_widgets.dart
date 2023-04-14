import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/logic/bloc_user/user_bloc.dart';

import '../../constants/global_variable.dart';

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
            return Column(
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
            );
          },
          itemCount: 4),
    );
  }
}

class HomeProductScroller extends StatelessWidget {
  const HomeProductScroller({
    super.key,
    required this.images,
  });

  final List images;

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
              child: Container(
                height: 220,
                width: 200,
                color: Colors.transparent,
                child: Column(
                  children: [
                    Image.network(
                      images[index]['image'],
                      fit: BoxFit.contain,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                        ),
                        child: Text(
                          images[index]['text'],
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${images[index]['price']} تومان  ',
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: images.length,
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
    return Row(
      children: const [
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
