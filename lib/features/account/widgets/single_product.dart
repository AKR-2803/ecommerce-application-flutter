import 'package:ecommerce_major_project/main.dart';
import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  SingleProduct({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: mq.width * .0125),
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 1.5),
              borderRadius: BorderRadius.circular(mq.width * .0125),
              color: Colors.white),
          child: Container(
            width: mq.width * .45,
            padding: EdgeInsets.all(mq.width * .025),
            child: Image.network(
              image,
              fit: BoxFit.fitHeight,
              width: mq.width * .45,
            ),
          ),
        ));
  }
}
