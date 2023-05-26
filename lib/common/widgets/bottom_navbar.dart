import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommerce_major_project/main.dart';
import 'package:ecommerce_major_project/providers/user_provider.dart';
import 'package:ecommerce_major_project/constants/global_variables.dart';
import 'package:ecommerce_major_project/features/home/screens/home_screen.dart';
import 'package:ecommerce_major_project/features/cart/screens/cart_screen.dart';
import 'package:ecommerce_major_project/features/account/screens/account_screen.dart';

class BottomNavbar extends StatefulWidget {
  static const String routeName = "/actual-home";
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    myTextTheme = Theme.of(context).textTheme;

    // int userCartLen =
    //     Provider.of<UserProvider>(context, listen: false).user.cart.length;
    final userCartLen = context.watch<UserProvider>().user.cart.length;

    print("Cart length in bottom bar is  ===> $userCartLen");
    return BottomNavigationBar(
      currentIndex: _page,
      selectedItemColor: GlobalVariables.selectedNavBarColor,
      unselectedItemColor: GlobalVariables.unselectedNavBarColor,
      backgroundColor: GlobalVariables.backgroundColor,
      iconSize: 28,
      onTap: updatePage,
      items: [
        //HOME PAGE
        BottomNavigationBarItem(
          icon: Container(
            width: bottomBarWidth,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth),
              ),
            ),
            child: const Icon(Icons.home_outlined),
          ),
          label: '',
        ),
        //ACCOUNT
        BottomNavigationBarItem(
          icon: Container(
            width: bottomBarWidth,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth),
              ),
            ),
            child: const Icon(Icons.person_outlined),
          ),
          label: '',
        ),
        //CART
        BottomNavigationBarItem(
          icon: Container(
            width: bottomBarWidth,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: _page == 2
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.backgroundColor,
                  width: bottomBarBorderWidth,
                ),
              ),
            ),
            child: badges.Badge(
              // displaying no of items in cart
              badgeContent: Text("$userCartLen",
                  style: const TextStyle(color: Colors.white)),

              badgeStyle: const badges.BadgeStyle(
                  badgeColor: Color.fromARGB(255, 19, 17, 17)),
              child: const Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
          ),
          label: '',
        ),
      ],
    );
  }
}
