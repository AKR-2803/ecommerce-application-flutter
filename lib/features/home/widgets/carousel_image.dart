import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_major_project/constants/global_variables.dart';
import 'package:ecommerce_major_project/main.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map((imageUrl) {
        return Builder(
          builder: (context) => Container(
            padding: EdgeInsets.symmetric(horizontal: mq.height * .025),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  height: mq.width * .48,
                )),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        enlargeCenterPage: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 1500),

        // aspectRatio: 16 / 9,
        autoPlayCurve: Curves.easeInOutCubic,

        scrollPhysics: ClampingScrollPhysics(),
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        viewportFraction: 1,
        height: mq.width * .4,
      ),
    );
  }
}
