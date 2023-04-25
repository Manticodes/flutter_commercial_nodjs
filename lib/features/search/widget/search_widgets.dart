import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/model/product.dart';

class SearchWidgets extends StatelessWidget {
  const SearchWidgets({Key? key, required this.products}) : super(key: key);
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        Product product = products[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            width: double.infinity,
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Image.network(
                products[index].images[0],
                width: MediaQuery.of(context).size.width * 0.4,
                height: 200,
                fit: BoxFit.cover,
              ),
              Flexible(
                child: Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 8),
                          child: Text(
                            product.name,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 8),
                          child: Text(
                            product.description,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 13.0, top: 8),
                          child: Text.rich(TextSpan(
                            children: [
                              WidgetSpan(
                                  child: Icon(
                                Icons.attach_money_outlined,
                                size: 20,
                                color: Colors.green,
                              )),
                              WidgetSpan(child: Text(product.price.toString())),
                              WidgetSpan(child: Text('  تومان'))
                            ],
                          )),
                        ),
                      ]),
                ),
              )
            ]),
          ),
        );
      },
      itemCount: products.length,
    );
  }
}
