import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_commercial_nodjs/constants/global_variable.dart';

class CarouselSliderImage extends StatelessWidget {
  const CarouselSliderImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: carouselImages.map((e) {
        return Builder(
          builder: (BuildContext context) => Image.network(
            e,
            height: 200,
            fit: BoxFit.cover,
          ),
        );
      }).toList(),
      options: CarouselOptions(
          viewportFraction: 1,
          autoPlay: true,
          height: MediaQuery.of(context).size.height * 0.25,
          autoPlayInterval: const Duration(seconds: 7)),
    );
  }
}
