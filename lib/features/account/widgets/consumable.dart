import 'package:flutter/material.dart';

import '../../../model/order.dart';

class AccountTopButton extends StatelessWidget {
  final String text;
  final VoidCallback func;
  const AccountTopButton({
    super.key,
    required this.text,
    required this.func,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: InkWell(
        onTap: func,
        child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.42,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
                color: const Color.fromARGB(255, 237, 231, 231)),
            child: Center(
                child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ))),
      ),
    );
  }
}

class ProductScroller extends StatelessWidget {
  const ProductScroller({
    super.key,
    required this.orders,
  });

  final List<Order>? orders;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 300,
      width: double.infinity,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: orders != null
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Flexible(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                  color: Colors.white,
                                  child: Image.network(
                                      orders![index].products[0].images[0])),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(" تومان " +
                                orders![index].totalPrice.toString() +
                                " : مجموع قیمت"),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: orders!.length,
                )
              : const Text(
                  'هیچ سفارشی یافت نشد',
                  style: TextStyle(fontSize: 30),
                )),
    );
  }
}
