import 'package:flutter/material.dart';

import '../../../model/order.dart';
import '../../search/widget/stars.dart';

class OrderProductList extends StatelessWidget {
  OrderProductList({Key? key, required this.order}) : super(key: key);
  final Order order;
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]},';

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Column(
              children: order.products.map((e) {
            int quantity = e.quantity.toInt();
            double avgStar = 0;
            int index = order.products.indexOf(e);

            if (e.ratings != null) {}
            var ratingList = e.ratings;
            double totalRating = 0;
            for (var i = 0; i < ratingList!.length; i++) {
              totalRating += ratingList[i].rate;
            }
            if (totalRating != 0) {
              avgStar = totalRating / ratingList.length;
            }

            var aPrice =
                e.price.round().toString().replaceAllMapped(reg, mathFunc);

            var totalPrice = (e.price * quantity)
                .round()
                .toString()
                .replaceAllMapped(reg, mathFunc);
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(
                            height: 3,
                          ),
                          Text(e.name,
                              textAlign: TextAlign.right,
                              softWrap: true,
                              textDirection: TextDirection.rtl,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 5),
                            child: Text.rich(
                                textAlign: TextAlign.right,
                                TextSpan(
                                  children: [
                                    const WidgetSpan(
                                        child: Text(
                                      '  تومان  ',
                                      style: TextStyle(fontSize: 15),
                                    )),
                                    WidgetSpan(
                                      child: Text(
                                        aPrice,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0, top: 5),
                            child: Text(
                              '${e.category} : دسته ',
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0, top: 5),
                            child: Stars(
                              rating: avgStar,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0, top: 5),
                            child: Text(
                              '${order.quantity[index]} : تعداد ',
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        e.images[0],
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.25,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(
                    color: Color.fromARGB(190, 138, 143, 146),
                  ),
                )
              ],
            );
          }).toList())
        ]));
  }
}
