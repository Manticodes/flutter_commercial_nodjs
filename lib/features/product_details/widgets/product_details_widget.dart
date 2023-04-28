import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import '../../../model/product.dart';

class ProductDetailsCarousel extends StatefulWidget {
  ProductDetailsCarousel({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<ProductDetailsCarousel> createState() => _ProductDetailsCarouselState();
}

class _ProductDetailsCarouselState extends State<ProductDetailsCarousel> {
  final CarouselController _controller = CarouselController();

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: CarouselSlider.builder(
              carouselController: _controller,
              itemCount: widget.product.images.length,
              itemBuilder: (context, index, realIndex) {
                return Image.network(widget.product.images[index]);
              },
              options: CarouselOptions(
                enlargeCenterPage: true,
                aspectRatio: 1.3,
                viewportFraction: 0.7,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.product.images.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Color.fromARGB(255, 218, 96, 96)
                            : Color.fromARGB(255, 239, 9, 9))
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}

class CostumDivider extends StatelessWidget {
  const CostumDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 4,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 158, 156, 156),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3))
            ]),
      ),
    );
  }
}

class ProductDescription extends StatefulWidget {
  ProductDescription({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');

  String Function(Match) mathFunc = (Match match) => '${match[1]},';

  bool isReadmore = false;

  @override
  Widget build(BuildContext context) {
    String price =
        widget.product.price.round().toString().replaceAllMapped(reg, mathFunc);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text.rich(TextSpan(children: [
                const WidgetSpan(
                    child: Text(
                  'تومان ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                WidgetSpan(
                    child: Text(
                  price,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 232, 107, 98),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
                const WidgetSpan(
                    child: Text(
                  ' : قیمت',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ]))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
          child: Text.rich(
            TextSpan(
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Color.fromARGB(255, 113, 113, 113),
                  fontFamily: 'Vazir',
                ),
                children: [
                  TextSpan(
                    text:
                        'گوشی موبایل iPhone 13 CH پرچم‌دار جدید شرکت اپل است که با چند ویژگی جدید و دوربین دوگانه روانه بازار شده است. نمایشگر آیفون 13 به پنل Super Retina مجهز ‌شده است تا تصاویر بسیار مطلوبی را به کاربر عرضه کند. این نمایشگر رزولوشن بسیار بالایی دارد؛ به‌طوری‌که در اندازه­‌ی 6.1 اینچی‌اش، حدود 460 پیکسل را در هر اینچ جا داده است. امکان شارژ بی‌‌سیم باتری در این گوشی وجود دارد. تشخیص چهره با استفاده از دوربین جلو دیگر ویژگی است که در آیفون جدید اپل به کار گرفته شده است. از نظر سخت‌‌ا ...',
                  ),
                ]),
            maxLines: isReadmore ? null : 3,
            overflow: isReadmore ? TextOverflow.visible : TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
            textDirection: TextDirection.rtl,
          ),
        ),
        InkWell(
          child: Text(isReadmore ? 'پنهان کردن متن' : 'ادامه مطلب',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              )),
          onTap: () {
            setState(() {
              isReadmore = !isReadmore;
            });
          },
        )
      ],
    );
  }
}
