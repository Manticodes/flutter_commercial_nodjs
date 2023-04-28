import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
              )
            ]),
      ),
    );
  }
}

class ProductDescription extends StatelessWidget {
  const ProductDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
