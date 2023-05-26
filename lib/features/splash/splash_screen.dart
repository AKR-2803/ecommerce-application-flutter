import 'package:ecommerce_major_project/features/splash/widgets/body.dart';
import 'package:ecommerce_major_project/main.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    // You have to call it on your starting screen
    // SizeConfig().init(context);
    return const Scaffold(
      body: Body(),
    );
  }
}




/*

import 'package:ecommerce_major_project/common/widgets/bottom_bar.dart';
import 'package:ecommerce_major_project/features/admin/screens/admin_screen.dart';
import 'package:ecommerce_major_project/features/auth/screens/auth_screen.dart';
import 'package:ecommerce_major_project/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    print("\n\niniside splash screen initState");

    authService.getUserData(context);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   authService.getUserData(context);
    //   print(
    //       "\n\n\nuser type splash init before future: ${Provider.of<UserProvider>(context, listen: false).user.type}");
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "\n\n\nuser type splash build : ${Provider.of<UserProvider>(context, listen: true).user.type}");
    return Scaffold(
        body: FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 5000), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Provider.of<UserProvider>(context,
                        listen: false)
                    .user
                    .token
                    .isNotEmpty
                ? Provider.of<UserProvider>(context, listen: false).user.type ==
                        'user'
                    ? const BottomBar()
                    : const AdminScreen()
                : const AuthScreen(),
          ),
        );
      }),
      builder: (context, snapshot) {
        return Center(
            child: Container(
          color: Colors.amberAccent,
          alignment: Alignment.center,
          height: 400,
          width: 400,
          child: const Text(
            // "User type is : ${Provider.of<UserProvider>(context).user.toJson()}",
            "Splash Screen...",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ));
      },
    ));
    // return Scaffold(
    //   body: Provider.of<UserProvider>(context, listen: true)
    //           .user
    //           .token
    //           .isNotEmpty
    //       ? Provider.of<UserProvider>(context, listen: true).user.type == 'user'
    //           ? const BottomBar()
    //           : const AdminScreen()
    //       : const AuthScreen(),
    // );
  }
}

    // Center(
    //     child: Container(
    //   color: Colors.amberAccent,
    //   alignment: Alignment.center,
    //   height: 400,
    //   width: 400,
    //   child: const Text(
    //     // "User type is : ${Provider.of<UserProvider>(context).user.toJson()}",
    //     "Splash Screen...",
    //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    //   ),
    // )),


    */


