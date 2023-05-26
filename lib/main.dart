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

// main function

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
        // colorScheme:
        //     const ColorScheme.light(primary: GlobalVariables.secondaryColor),
        // appBarTheme: const AppBarTheme(elevation: 0),
        // iconTheme: const IconThemeData(color: Colors.black),
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
      //
      onGenerateRoute: (settings) => generateRoute(settings),
      //
      //
      //
      // home: SpeechExample(),

      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'
              ? const BottomBar()
              : const AdminScreen()
          : const AuthScreen(),
    );
  }
}






//common appBar
/*

 appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        // automaticallyImplyLeading: true,
        leading: Padding(
          padding: EdgeInsets.all(mq.width * .025).copyWith(right: 0),
          child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)), // height: 5,
          // height: mq.height * .04,
        ),

        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: mq.width * 0.035),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      // isSearchOn = true;
                    });
                  },
                  child: SvgPicture.asset("assets/images/search-svg.svg",
                      height: 25),
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
        ],
      ),
     
*/


//



/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommerce_major_project/router.dart';
import 'package:ecommerce_major_project/providers/user_provider.dart';
import 'package:ecommerce_major_project/common/widgets/bottom_bar.dart';
import 'package:ecommerce_major_project/constants/global_variables.dart';
import 'package:ecommerce_major_project/features/auth/screens/auth_screen.dart';
import 'package:ecommerce_major_project/features/auth/services/auth_service.dart';
import 'package:ecommerce_major_project/features/admin/screens/admin_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MaterialApp(home: MyApp())));
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
        // colorScheme:
        //     const ColorScheme.light(primary: GlobalVariables.secondaryColor),
        appBarTheme: const AppBarTheme(elevation: 0),
        // iconTheme: const IconThemeData(color: Colors.black),
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      //
      //
      //
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'
              ? const BottomBar()
              : const AdminScreen()
          : const AuthScreen(),
      // home: AuthScreen(),
      // home: Provider.of<UserProvider>(context).user.token.isNotEmpty
      //     ? Provider.of<UserProvider>(context).user.type == 'user'
      //         ? const BottomBar()
      //         : const BottomBar()
      //     : const AuthScreen(),
    );
  }
}
*/

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


//awesome notifications example : https://github.com/rafaelsetragni/awesome_notifications/blob/master/example/lib/main.dart
/*
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  // Always initialize Awesome Notifications
  await NotificationController.initializeLocalNotifications();
  runApp(const MyApp());
}

///  *********************************************
///     NOTIFICATION CONTROLLER
///  *********************************************
///
class NotificationController {
  static ReceivedAction? initialAction;

  ///  *********************************************
  ///     INITIALIZATIONS
  ///  *********************************************
  ///
  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
        null, //'resource://drawable/res_app_icon',//
        [
          NotificationChannel(
              channelKey: 'alerts',
              channelName: 'Alerts',
              channelDescription: 'Notification tests as alerts',
              playSound: true,
              onlyAlertOnce: true,
              groupAlertBehavior: GroupAlertBehavior.Children,
              importance: NotificationImportance.High,
              defaultPrivacy: NotificationPrivacy.Private,
              defaultColor: Colors.deepPurple,
              ledColor: Colors.deepPurple)
        ],
        debug: true);

    // Get initial notification action is optional
    initialAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: false);
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS LISTENER
  ///  *********************************************
  ///  Notifications events are only delivered after call this method
  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS
  ///  *********************************************
  ///
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.actionType == ActionType.SilentAction ||
        receivedAction.actionType == ActionType.SilentBackgroundAction) {
      // For background actions, you must hold the execution until the end
      print(
          'Message sent via notification input: "${receivedAction.buttonKeyInput}"');
      await executeLongTaskInBackground();
    } else {
      MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
          '/notification-page',
          (route) =>
              (route.settings.name != '/notification-page') || route.isFirst,
          arguments: receivedAction);
    }
  }

  ///  *********************************************
  ///     REQUESTING NOTIFICATION PERMISSIONS
  ///  *********************************************
  ///
  static Future<bool> displayNotificationRationale() async {
    bool userAuthorized = false;
    BuildContext context = MyApp.navigatorKey.currentContext!;
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Get Notified!',
                style: Theme.of(context).textTheme.titleLarge),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/animated-bell.gif',
                        height: MediaQuery.of(context).size.height * 0.3,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                    'Allow Awesome Notifications to send you beautiful notifications!'),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Deny',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () async {
                    userAuthorized = true;
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Allow',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.deepPurple),
                  )),
            ],
          );
        });
    return userAuthorized &&
        await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  ///  *********************************************
  ///     BACKGROUND TASKS TEST
  ///  *********************************************
  static Future<void> executeLongTaskInBackground() async {
    print("starting long task");
    await Future.delayed(const Duration(seconds: 4));
    final url = Uri.parse("http://google.com");
    final re = await http.get(url);
    print(re.body);
    print("long task done");
  }

  ///  *********************************************
  ///     NOTIFICATION CREATION METHODS
  ///  *********************************************
  ///
  static Future<void> createNewNotification() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: -1, // -1 is replaced by a random number
            channelKey: 'alerts',
            title: 'Huston! The eagle has landed!',
            body:
                "A small step for a man, but a giant leap to Flutter's community!",
            bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
            largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
            //'asset://assets/images/balloons-in-sky.jpg',
            notificationLayout: NotificationLayout.BigPicture,
            payload: {'notificationId': '1234567890'}),
        actionButtons: [
          NotificationActionButton(key: 'REDIRECT', label: 'Redirect'),
          NotificationActionButton(
              key: 'REPLY',
              label: 'Reply Message',
              requireInputText: true,
              actionType: ActionType.SilentAction),
          NotificationActionButton(
              key: 'DISMISS',
              label: 'Dismiss',
              actionType: ActionType.DismissAction,
              isDangerousOption: true)
        ]);
  }

  static Future<void> scheduleNewNotification() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: -1, // -1 is replaced by a random number
            channelKey: 'alerts',
            title: "Huston! The eagle has landed!",
            body:
                "A small step for a man, but a giant leap to Flutter's community!",
            bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
            largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
            //'asset://assets/images/balloons-in-sky.jpg',
            notificationLayout: NotificationLayout.BigPicture,
            payload: {
              'notificationId': '1234567890'
            }),
        actionButtons: [
          NotificationActionButton(key: 'REDIRECT', label: 'Redirect'),
          NotificationActionButton(
              key: 'DISMISS',
              label: 'Dismiss',
              actionType: ActionType.DismissAction,
              isDangerousOption: true)
        ],
        schedule: NotificationCalendar.fromDate(
            date: DateTime.now().add(const Duration(seconds: 10))));
  }

  static Future<void> resetBadgeCounter() async {
    await AwesomeNotifications().resetGlobalBadge();
  }

  static Future<void> cancelNotifications() async {
    await AwesomeNotifications().cancelAll();
  }
}

///  *********************************************
///     MAIN WIDGET
///  *********************************************
///
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // The navigator key is necessary to navigate using static methods
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Color mainColor = const Color(0xFF9D50DD);

  @override
  State<MyApp> createState() => _AppState();
}

class _AppState extends State<MyApp> {
  // This widget is the root of your application.

  static const String routeHome = '/', routeNotification = '/notification-page';

  @override
  void initState() {
    NotificationController.startListeningNotificationEvents();
    super.initState();
  }

  List<Route<dynamic>> onGenerateInitialRoutes(String initialRouteName) {
    List<Route<dynamic>> pageStack = [];
    pageStack.add(MaterialPageRoute(
        builder: (_) =>
            const MyHomePage(title: 'Awesome Notifications Example App')));
    if (initialRouteName == routeNotification &&
        NotificationController.initialAction != null) {
      pageStack.add(MaterialPageRoute(
          builder: (_) => NotificationPage(
              receivedAction: NotificationController.initialAction!)));
    }
    return pageStack;
  }

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeHome:
        return MaterialPageRoute(
            builder: (_) =>
                const MyHomePage(title: 'Awesome Notifications Example App'));

      case routeNotification:
        ReceivedAction receivedAction = settings.arguments as ReceivedAction;
        return MaterialPageRoute(
            builder: (_) => NotificationPage(receivedAction: receivedAction));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Notifications - Simple Example',
      navigatorKey: MyApp.navigatorKey,
      onGenerateInitialRoutes: onGenerateInitialRoutes,
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}

///  *********************************************
///     HOME PAGE
///  *********************************************
///
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Push the buttons below to create new notifications',
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 20),
            FloatingActionButton(
              heroTag: '1',
              onPressed: () => NotificationController.createNewNotification(),
              tooltip: 'Create New notification',
              child: const Icon(Icons.outgoing_mail),
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              heroTag: '2',
              onPressed: () => NotificationController.scheduleNewNotification(),
              tooltip: 'Schedule New notification',
              child: const Icon(Icons.access_time_outlined),
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              heroTag: '3',
              onPressed: () => NotificationController.resetBadgeCounter(),
              tooltip: 'Reset badge counter',
              child: const Icon(Icons.exposure_zero),
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              heroTag: '4',
              onPressed: () => NotificationController.cancelNotifications(),
              tooltip: 'Cancel all notifications',
              child: const Icon(Icons.delete_forever),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

///  *********************************************
///     NOTIFICATION PAGE
///  *********************************************
///
class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key, required this.receivedAction})
      : super(key: key);

  final ReceivedAction receivedAction;

  @override
  Widget build(BuildContext context) {
    bool hasLargeIcon = receivedAction.largeIconImage != null;
    bool hasBigPicture = receivedAction.bigPictureImage != null;
    double bigPictureSize = MediaQuery.of(context).size.height * .4;
    double largeIconSize =
        MediaQuery.of(context).size.height * (hasBigPicture ? .12 : .2);

    return Scaffold(
      appBar: AppBar(
        title: Text(receivedAction.title ?? receivedAction.body ?? ''),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height:
                    hasBigPicture ? bigPictureSize + 40 : largeIconSize + 60,
                child: hasBigPicture
                    ? Stack(
                        children: [
                          if (hasBigPicture)
                            FadeInImage(
                              placeholder: const NetworkImage(
                                  'https://cdn.syncfusion.com/content/images/common/placeholder.gif'),
                              //AssetImage('assets/images/placeholder.gif'),
                              height: bigPictureSize,
                              width: MediaQuery.of(context).size.width,
                              image: receivedAction.bigPictureImage!,
                              fit: BoxFit.cover,
                            ),
                          if (hasLargeIcon)
                            Positioned(
                              bottom: 15,
                              left: 20,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(largeIconSize)),
                                child: FadeInImage(
                                  placeholder: const NetworkImage(
                                      'https://cdn.syncfusion.com/content/images/common/placeholder.gif'),
                                  //AssetImage('assets/images/placeholder.gif'),
                                  height: largeIconSize,
                                  width: largeIconSize,
                                  image: receivedAction.largeIconImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                        ],
                      )
                    : Center(
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.all(Radius.circular(largeIconSize)),
                          child: FadeInImage(
                            placeholder: const NetworkImage(
                                'https://cdn.syncfusion.com/content/images/common/placeholder.gif'),
                            //AssetImage('assets/images/placeholder.gif'),
                            height: largeIconSize,
                            width: largeIconSize,
                            image: receivedAction.largeIconImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    if (receivedAction.title?.isNotEmpty ?? false)
                      TextSpan(
                        text: receivedAction.title!,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    if ((receivedAction.title?.isNotEmpty ?? false) &&
                        (receivedAction.body?.isNotEmpty ?? false))
                      TextSpan(
                        text: '\n\n',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    if (receivedAction.body?.isNotEmpty ?? false)
                      TextSpan(
                        text: receivedAction.body!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                  ]))
                ],
              ),
            ),
            Container(
              color: Colors.black12,
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              child: Text(receivedAction.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
*/


