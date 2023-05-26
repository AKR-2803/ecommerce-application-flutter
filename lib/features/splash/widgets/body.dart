import 'package:ecommerce_major_project/common/widgets/bottom_bar.dart';
import 'package:ecommerce_major_project/common/widgets/custom_button.dart';
import 'package:ecommerce_major_project/features/admin/screens/admin_screen.dart';
import 'package:ecommerce_major_project/features/auth/screens/auth_screen.dart';
import 'package:ecommerce_major_project/features/splash/widgets/splash_content.dart';
import 'package:ecommerce_major_project/main.dart';
import 'package:ecommerce_major_project/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// This is the best practice

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double opacity = 0.3;
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to eSHOP, Let's continue",
      "image": "assets/images/splash_1.png"
    },
    {
      "text": "Easy Quick and Affordable",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "Let's jump right in\nJust stay at home with us",
      "image": "assets/images/splash_3.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                    opacity = 1;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: mq.width * 0.05),
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    const Spacer(flex: 3),
                    if (currentPage == 2)
                      AnimatedOpacity(
                        opacity: opacity,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOutBack,
                        child: CustomButton(
                          text: "Continue",
                          onTap: () {
                            setState(() {
                              opacity = 0.5;
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        Provider.of<UserProvider>(context)
                                                .user
                                                .token
                                                .isNotEmpty
                                            ? Provider.of<UserProvider>(context)
                                                        .user
                                                        .type ==
                                                    'user'
                                                ? const BottomBar()
                                                : const AdminScreen()
                                            : const AuthScreen()));
                          },
                        ),
                      ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index
            ? const Color(0xFFFF7643)
            : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
