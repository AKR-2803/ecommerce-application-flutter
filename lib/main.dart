// pending/bugs
/* 

To be done features

- reCaptcha
  -- integration in the SignUp fucntionality or anywhere else
  -- ref. : https://www.youtube.com/watch?v=jrbdzUszfE4
  -- ref. : https://www.youtube.com/watch?v=CIBHfT282n0


- (context.mounted) used thrice in auth_service.dart if that is causing an issue
  to locate search this comment : //dont use context across asynchronous gaps


-Implement FORGOT PASSWORD flow in MongoDB, take help


- 3:15:00 make middleware "auth"

- 4:25:00 top categories list

- 5:26:00 finish constructor 

- 5:36:30 : why only one admin, how to add multiple
- just keep user.id in the admin model also
- which he removed at 5:36:40


- 6:08:00 : adding products


  //ISSUE : we want to show loader when products == null
  //but when the admin has not added any products we are showing
  //"Add some products to sell"
  //ensure loader also works when the producs are actually added
  //right now  it looks like the Loader is not shown because the list is empty and the text is shown
  //check whats the issue

  - //ISSUE :  home_services.dart line 25, type 'int' is not a subtype of type 'double' in type cast
  - try to change the product model or anything just solve the issue else further development is not possible


- ISSUE : Can't get the user.type using UserProvider, i.e.  Provider.of<UserProvider>(context).user.type , can get
  name, token , but not type, hence it redirects to admin page even is user.type is "user" 


To Be Continued...
- 8:05::10 Implementing CART Functionality


// 9:55:10 Checking order placing module
-- Add your SBI debit card and place the order using that to check if the order module is working or not


// 11:04:40 implement Sales chart feature
use this package: 

fl_chart : https://pub.dev/packages/fl_chart
fl_chart DOCS : https://github.com/imaNNeo/fl_chart/blob/master/repo_files/documentations/index.md

to be implemented in this file : lib\features\admin\screens\analytics_screen.dart


Tab Moves Focus [CRTL + M]

//
//
//

--UI changes

// use appBar only in homescreen, no need for custom body 
// and user searchDelegate for search functionality


11-05-23 bugs/changes
-- customise snackBar [success snackBar] [ error snackBar ]
-- scrolling issue HomeScreen  :

https://www.google.com/search?q=ScrollController+not+working+effect+flutter&sxsrf=APwXEde2OOaZS-i1XV-wTZhGUjgiQvztqg%3A1683804371689&ei=09BcZL66KeyZ4-EP6aiUqAI&ved=0ahUKEwj-78eLlO3-AhXszDgGHWkUBSUQ4dUDCBA&uact=5&oq=ScrollController+not+working+effect+flutter&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAzIICCEQoAEQwwQyCAghEKABEMMEOgoIABBHENYEELADSgQIQRgAUFRY6RNg4hRoAXABeAGAAb8CiAHKHpIBCDAuMy4xMS4ymAEAoAEByAEIwAEB&sclient=gws-wiz-serp

-- showing wishList [removing from wishList]

-- showing Loader when switching categories in TOP Categories

--if time,try  empty cart feature, PickeUpWhereULeftOff 
Explanation : See Amazon app when the cart is empty, it shows pickupwhere u left off textbutton, onTap it open a bottom sheet with you recent purchases or the stuff you had in the cart recently. 
we can save last three recent items user added in the cart and on tapping the button showBottomSheet with horizontal list of the imags of the products, on tapping it should lead to the products detail page.

-search via audio

--navbar route package for navigation with bottomnavigationbar

-- out of stock condition [when product is out o stock do not move to checkout]

-- your orders -> SEE ALL -> Show a listview with delivered On 

--change address screen

-- search Ranking problem still!, deleting and adding to the array not working properly

-- eSHOP logo on homeScreen

-- add to product schema/model 

String brandName

*/

/*

Keywords : 


Frontend  ==>
Dart:
Flutter : 

Backend  ==>

Database : MongoDB 
NodeJS, ExpressJS, mongoose, jsonwebtoken

API, Express router
Middleware

State persistence | State management
Provider

*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommerce_major_project/router.dart';
import 'package:ecommerce_major_project/providers/user_provider.dart';
import 'package:ecommerce_major_project/common/widgets/bottom_bar.dart';
import 'package:ecommerce_major_project/constants/global_variables.dart';
import 'package:ecommerce_major_project/features/auth/screens/auth_screen.dart';
import 'package:ecommerce_major_project/features/admin/screens/admin_screen.dart';
import 'package:ecommerce_major_project/features/auth/services/auth_service.dart';
import 'package:ecommerce_major_project/features/home/providers/search_provider.dart';
import 'package:ecommerce_major_project/features/home/providers/filter_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => SearchProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => FilterProvider(),
    ),
  ], child: const MyApp()));
}

late Size mq;
late TextTheme myTextTheme;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce App',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Poppins'),
        ),
      ),
      //
      //
      onGenerateRoute: (settings) => generateRoute(settings),
      //
      //
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'
              ? const BottomBar()
              : const AdminScreen()
          : const AuthScreen(),
    );
  }
}



//mq table :
/*

mq.height * .025 = 21
mq.height * .05 = 42
mq.height * .1 = 84
mq.height * .2 = 168
mq.height * .3 = 253
mq.height * .4 = 337
mq.height * .5 = 421
mq.height * .6 = 506
mq.height * .7 = 590
mq.height * .8 = 674
mq.height * .9 = 759
mq.height *  1 = 843

mq.width * 0.0195 = 8
mq.width * .025 = 10
mq.width * .05 = 20
mq.width * .1 = 41    
mq.width * .2 = 82
mq.width * .3 = 123
mq.width * .4 = 164
mq.width * .5 = 205
mq.width * .6 = 246
mq.width * .7 = 288
mq.width * .8 = 329
mq.width * .9 = 370
mq.width *  1 = 411

ListView.builder(
            itemCount: 10,
            itemBuilder: ((context, index) {
              print(
                  "height ${index + 1} : ${(mq.height * (index + 1) * 0.1).toInt()}");

              print("\n\n\n");
              print("width : ${(mq.width * (index + 1) * 0.1).toInt()}");
              return Row(
                children: [
                  Text(
                      "height ${index + 1} : ${(mq.height * (index + 1) * 0.1).toInt()}"),
                  SizedBox(width: 10),
                  Text("width : ${(mq.width * (index + 1) * 0.1).toInt()}"),
                ],
              );
  }))
*/
