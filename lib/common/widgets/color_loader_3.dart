import "package:flutter/material.dart";
import 'dart:math';

class ColorLoader3 extends StatefulWidget {
  final double radius;
  final double dotRadius;

  const ColorLoader3({super.key, this.radius = 20.0, this.dotRadius = 5.0});

  @override
  State<ColorLoader3> createState() => _ColorLoader3State();
}

class _ColorLoader3State extends State<ColorLoader3>
    with SingleTickerProviderStateMixin {
  late Animation<double> animationRotation;
  late Animation<double> animationRadiusIn;
  late Animation<double> animationRadiusOut;
  late AnimationController controller;

  late double radius;
  late double dotRadius;

  @override
  void initState() {
    super.initState();

    radius = widget.radius;
    dotRadius = widget.dotRadius;

    // print(dotRadius);

    controller = AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: const Duration(milliseconds: 2000),
        vsync: this);

    animationRotation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    animationRadiusIn = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.75, 1.0, curve: Curves.elasticIn),
      ),
    );

    animationRadiusOut = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.25, curve: Curves.elasticOut),
      ),
    );

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0) {
          radius = widget.radius * animationRadiusIn.value;
        } else if (controller.value >= 0.0 && controller.value <= 0.25) {
          radius = widget.radius * animationRadiusOut.value;
        }
      });
    });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100.0,
        height: 100.0,
        //color: Colors.black12,
        child: Center(
          child: RotationTransition(
            turns: animationRotation,
            child: Center(
              child: Stack(
                children: <Widget>[
                  Transform.translate(
                    offset: const Offset(0.0, 0.0),
                    child: Dot(
                      radius: radius,
                      color: Colors.deepPurple,
                    ),
                  ),

                  // 1
                  Transform.translate(
                    offset: Offset(
                      radius * cos(0.0),
                      radius * sin(0.0),
                    ),
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.purple,
                    ),
                  ),
                  // 2
                  Transform.translate(
                    offset: Offset(
                      radius * cos(0.0 + 1 * pi / 4),
                      radius * sin(0.0 + 1 * pi / 4),
                    ),
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.purpleAccent,
                    ),
                  ),
                  // 3
                  Transform.translate(
                    offset: Offset(
                      radius * cos(0.0 + 2 * pi / 4),
                      radius * sin(0.0 + 2 * pi / 4),
                    ),
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  // 4
                  Transform.translate(
                    offset: Offset(
                      radius * cos(0.0 + 3 * pi / 4),
                      radius * sin(0.0 + 3 * pi / 4),
                    ),
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.deepPurple,
                    ),
                  ),
                  // 5
                  Transform.translate(
                    offset: Offset(
                      radius * cos(0.0 + 4 * pi / 4),
                      radius * sin(0.0 + 4 * pi / 4),
                    ),
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.purple,
                    ),
                  ),
                  // 6
                  Transform.translate(
                    offset: Offset(
                      radius * cos(0.0 + 5 * pi / 4),
                      radius * sin(0.0 + 5 * pi / 4),
                    ),
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.purpleAccent,
                    ),
                  ),
                  // 7
                  Transform.translate(
                    offset: Offset(
                      radius * cos(0.0 + 6 * pi / 4),
                      radius * sin(0.0 + 6 * pi / 4),
                    ),
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  // 7
                  Transform.translate(
                    offset: Offset(
                      radius * cos(0.0 + 7 * pi / 4),
                      radius * sin(0.0 + 7 * pi / 4),
                    ),
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class Dot extends StatelessWidget {
  final double? radius;
  final Color? color;

  Dot({super.key, this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
