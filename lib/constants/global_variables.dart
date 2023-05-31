import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ecommerce_major_project/main.dart';
import 'package:ecommerce_major_project/common/widgets/bottom_bar.dart';

// String uri = 'https://drab-teal-crayfish-hem.cyclic.app';
String uri = 'http://192.168.9.242:3000';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216)
    ],
    stops: [0.5, 1.0],
  );

  static final Color primaryGreyTextColor = Colors.grey.shade700;
  static final Color secondaryGreyTextColor = Colors.grey.shade600;
  static const TextStyle appBarTextStyle =
      TextStyle(fontStyle: FontStyle.normal, fontSize: 20, color: Colors.black);

  static const TextStyle whiteTextStlye = TextStyle(color: Colors.white);
  static const TextStyle greyTextStlye = TextStyle(color: Colors.grey);

  static const loginPageGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
    tileMode: TileMode.clamp,
    colors: [
      Color.fromARGB(255, 247, 247, 247),
      Color.fromARGB(255, 252, 251, 251),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundColor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.grey.shade800;
  static const unselectedNavBarColor = Colors.black87;

  static TextTheme myTextTheme = const TextTheme(
    // bodySmall: TextStyle(fontSize: 20, color: Colors.black),
    bodySmall: TextStyle(fontSize: 15, color: Colors.black),
    bodyMedium: TextStyle(fontSize: 20, color: Colors.black),
    bodyLarge: TextStyle(fontSize: 30, color: Colors.black),
  );

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];
  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Mobiles',
      'image': 'assets/images/mobile-svg.svg',
    },
    {
      'title': 'Essentials',
      'image': 'assets/images/essentials-svg.svg',
    },
    {
      'title': 'Appliances',
      'image': 'assets/images/appliances-svg.svg',
    },
    {
      'title': 'Books',
      'image': 'assets/images/books-svg.svg',
    },
    {
      'title': 'Fashion',
      'image': 'assets/images/fashion-svg.svg',
    },
  ];
  static const List<Map<String, String>> categoryImages2 = [
    {
      'title': 'Mobiles',
      'image': 'assets/images/mobiles-category.jpg',
    },
    {
      'title': 'Essentials',
      'image': 'assets/images/essentials-category.jpg',
    },
    {
      'title': 'Appliances',
      'image': 'assets/images/appliances-category.jpg',
    },
    {
      'title': 'Books',
      'image': 'assets/images/books-category.jpg',
    },
    {
      'title': 'Fashion',
      'image': 'assets/images/fashion-category.jpg',
    },
  ];

  static Route createRoute(Widget className) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => className,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.decelerate;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  static AppBar getAppBar({
    required BuildContext context,
    required dynamic onClickSearchNavigateTo,
    bool? wantBackNavigation = true,
    bool? wantActions = true,
    String? title = "",
  }) {
    return AppBar(
      title: Text("$title",
          style: appBarTextStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
      iconTheme: const IconThemeData(color: Colors.black),
      // automaticallyImplyLeading: true,
      leading: Padding(
        padding: EdgeInsets.all(mq.width * .025).copyWith(right: 0),
        child: wantBackNavigation!
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context))
            : InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, BottomBar.routeName);
                },
                child: Image.asset(
                  "assets/images/logo.png",
                ),
              ),
      ),
      backgroundColor: Colors.white,
      elevation: 2,
      actions: wantActions!
          ? [
              Padding(
                padding: EdgeInsets.only(right: mq.width * 0.035),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(createRoute(onClickSearchNavigateTo));
                      },
                      child: SvgPicture.asset(
                        "assets/images/search-svg.svg",
                        height: 25,
                      ),
                    ),
                    SizedBox(width: mq.width * .04),
                    InkWell(
                        onTap: () {
                          // Scaffold.of(context).openDrawer();
                          // _scaffoldKey.currentState!.openEndDrawer();
                        },
                        child: const Icon(Icons.mic, size: 30)),
                  ],
                ),
              ),
            ]
          : [],
    );
  }

  static AppBar getAdminAppBar({
    required BuildContext context,
    String? title = "",
  }) {
    return AppBar(
      title: Text("$title",
          style: appBarTextStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
      iconTheme: const IconThemeData(color: Colors.black),
      // automaticallyImplyLeading: true,
      leading: Padding(
        padding: EdgeInsets.all(mq.width * .025).copyWith(right: 0),
        child: InkWell(
          onTap: () {},
          child: Image.asset(
            "assets/images/logo.png",
          ),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 2,
      actions: [
        TextButton(
            onPressed: () {},
            child: Text(
              "Admin",
              style: GlobalVariables.appBarTextStyle.copyWith(fontSize: 16),
            ))
      ],
    );
  }
}
