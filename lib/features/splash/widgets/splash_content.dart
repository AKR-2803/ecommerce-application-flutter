import 'package:ecommerce_major_project/main.dart';
import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 40,
              // height: mq.height * .04,
            ),
            SizedBox(width: mq.width * .03),
            Text(
              "eSHOP",
              style: TextStyle(
                fontSize: 50,
                color: Colors.orange.shade400,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        Text(
          text!,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        const Spacer(flex: 2),
        Image.asset(
          image!,
          height: 265,
          width: 235,
        ),
      ],
    );
  }
}
