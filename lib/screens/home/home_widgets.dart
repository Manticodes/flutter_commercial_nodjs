import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/logic/bloc_user/user_bloc.dart';
import 'package:flutter_commercial_nodjs/model/product.dart';
import 'package:flutter_commercial_nodjs/screens/home/category_deals_screen.dart';

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
              child: SingleProductImage(
                index: index,
                images: images,
              ),
            );
          },
          itemCount: images.length,
        ),
      ),
    );
  }
}

class SingleProductImage extends StatelessWidget {
  const SingleProductImage({
    super.key,
    required this.images,
    required this.index,
  });
  final int index;
  final List images;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  height: 200,
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
