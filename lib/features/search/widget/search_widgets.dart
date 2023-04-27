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
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  products[index].images[0],
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Flexible(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 5),
                        child: Text(
                          product.name,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 5),
                        child: Text.rich(TextSpan(
                          children: [
                            const WidgetSpan(
                                child: Icon(
                              Icons.attach_money_outlined,
                              size: 20,
                              color: Colors.green,
                            )),
                            WidgetSpan(
                              child: Text(
                                product.price.round().toString(),
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const WidgetSpan(
                                child: Text(
                              '  تومان',
                              style: TextStyle(fontSize: 15),
                            ))
                          ],
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 5),
                        child: Text(
                          product.category + ' : دسته ',
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 5),
                        child: product.quantity > 0
                            ? product.quantity < 6
                                ? Text.rich(TextSpan(
                                    children: [
                                      WidgetSpan(
                                          child: Text(
                                        ' عدد در انبار موجود می باشد ',
                                        style: TextStyle(color: Colors.red),
                                      )),
                                      WidgetSpan(
                                          child: Text(
                                        product.quantity.round().toString(),
                                        style: TextStyle(color: Colors.red),
                                      )),
                                      const WidgetSpan(
                                          child: Text(
                                        ' فقط ',
                                        style: TextStyle(color: Colors.red),
                                      )),
                                    ],
                                  ))
                                : Text('موجود در انباز')
                            : Text('موجود نمی باشد'),
                      ),
                    ]),
              )
            ]),
          ),
        );
      },
      itemCount: products.length,
    );
  }
}
