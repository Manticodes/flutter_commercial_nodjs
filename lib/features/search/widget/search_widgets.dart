import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/model/product.dart';

class SearchWidgets extends StatelessWidget {
  const SearchWidgets({Key? key, required this.products}) : super(key: key);
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            width: double.infinity,
            color: Colors.amber,
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Image.network(
                products[index].images[0],
                width: MediaQuery.of(context).size.width * 0.4,
                height: 200,
                fit: BoxFit.cover,
              ),
              Flexible(
                child: Container(
                  child: Column(children: [
                    Text(
                      'sadasdasdasdasdasdsdsdassfdsfsdfsdfsdfsdfsd',
                      overflow: TextOverflow.clip,
                    ),
                    Text(
                      'sadasdasdasdasdasdsdsdassfdsfsdfsdfsdfsdfsd',
                      overflow: TextOverflow.clip,
                    )
                  ]),
                ),
              )
            ]),
          ),
        );
      },
      itemCount: 2,
    );
  }
}
