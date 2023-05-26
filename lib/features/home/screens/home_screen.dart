import 'package:ecommerce_major_project/common/widgets/custom_appbar.dart';
import 'package:ecommerce_major_project/features/search_delegate/my_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:ecommerce_major_project/main.dart';
import 'package:ecommerce_major_project/providers/user_provider.dart';
import 'package:ecommerce_major_project/constants/global_variables.dart';
import 'package:ecommerce_major_project/features/home/widgets/deal_of_day.dart';
import 'package:ecommerce_major_project/features/home/screens/my_end_drawer.dart';
import 'package:ecommerce_major_project/features/home/widgets/carousel_image.dart';
import 'package:ecommerce_major_project/features/home/services/home_services.dart';
import 'package:ecommerce_major_project/features/home/widgets/top_categories.dart';
import 'package:ecommerce_major_project/features/search/screens/search_screen.dart';
import 'package:ecommerce_major_project/features/home/providers/search_provider.dart';

// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => MySearchScreen(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(0.0, 1.0);
//       const end = Offset.zero;
//       const curve = Curves.decelerate;

//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       return SlideTransition(position: animation.drive(tween), child: child);
//     },
//   );
// }

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bool isSearchOn = false;
  // TextEditingController searchController = TextEditingController();

  // final historyLength = 5;

  // List<String> filteredSearchHistory = [];

  // String? selectedTerm;

  // HomeServices homeServices = HomeServices();
  // List<String>? searchHistoryList = [];
  // List<String>? productNames = [];

  // List<String>? searchSuggestionsList = [];

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // bool onChangeActive = false;

  // fetchAllProductsNames() async {
  //   productNames = await homeServices.fetchAllProductsNames(context);
  //   setState(() {});
  // }

  // fetchSearchHistory() async {
  //   searchHistoryList = await homeServices.fetchSearchHistory(context);
  //   setState(() {});
  // }

  // void navigateToSearchScreen(String query) {
  //   //make sure to pass the arguments here!
  //   Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  // }

  @override
  Widget build(BuildContext context) {
    // final searchProvider = Provider.of<SearchProvider>(context);
    // _searchHistory = searchProvider.getSearchlist;

    // print("\n\n==========> Product Names are : $productNames");
    // print("\n\n==========> _searchHistoryList : $searchHistoryList");

    mq = MediaQuery.of(context).size;
    return SafeArea(
      top: false,
      child: Scaffold(
        // key: _scaffoldKey,
        appBar: GlobalVariables.getAppBar(
            context: context,
            wantBackNavigation: false,
            onClickSearchNavigateTo: MySearchScreen()),

        // drawer: Drawer(backgroundColor: Colors.redAccent),

        //

        // appBar: PreferredSize(

        //   preferredSize: Size.fromHeight(mq.height * .5),
        //   child: Padding(
        //     padding: EdgeInsets.symmetric(horizontal: mq.width * .025)
        //         .copyWith(top: mq.height * 0.04),
        //     child: SizedBox(
        //       height: mq.height * .15,
        //       child: Padding(
        //         padding: EdgeInsets.only(right: mq.width * .03),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.end,
        //           children: [
        //             Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        //               isSearchOn
        //                   ? SizedBox(
        //                       width: mq.width * .75,
        //                       child: Column(
        //                         // mainAxisAlignment: MainAxisAlignment.center,
        //                         children: [
        //                           TextFormField(
        //                             controller: searchController,
        //                             autofocus: true,
        //                             cursorColor: Colors.grey.shade800,
        //                             onChanged: (val) {},
        //                             // when the search field is submitted
        //                             // redirect to search screen, i.e. to the screen
        //                             // with the relevant search query results
        //                             onFieldSubmitted: navigateToSearchScreen,
        //                             // textInputAction: TextInputAction.done,
        //                             decoration: InputDecoration(
        //                               filled: true,
        //                               fillColor: Colors.grey.shade200,
        //                               contentPadding: EdgeInsets.only(
        //                                   top: mq.width * .03),
        //                               border: const OutlineInputBorder(
        //                                   borderRadius: BorderRadius.all(
        //                                       Radius.circular(18)),
        //                                   borderSide: BorderSide(
        //                                       color: Colors.black38,
        //                                       width: 0.1)),
        //                               enabledBorder: const OutlineInputBorder(
        //                                   borderRadius: BorderRadius.all(
        //                                       Radius.circular(18)),
        //                                   borderSide: BorderSide(
        //                                       color: Colors.black38,
        //                                       width: 0.1)),
        //                               focusedBorder: const OutlineInputBorder(
        //                                   borderRadius: BorderRadius.all(
        //                                       Radius.circular(18)),
        //                                   borderSide: BorderSide(
        //                                       color: Colors.black38,
        //                                       width: 0.1)),
        //                               // border: null,
        //                               hintText: "Search",
        //                               hintStyle: const TextStyle(
        //                                   fontWeight: FontWeight.w300),
        //                               prefixIcon: Padding(
        //                                 padding: const EdgeInsets.all(15.0),
        //                                 child: SvgPicture.asset(
        //                                   "assets/images/search-svg.svg",
        //                                   height: 10,
        //                                   // width: 2,
        //                                 ),
        //                               ),
        //                               suffixIcon: Padding(
        //                                 padding: const EdgeInsets.all(15.0),
        //                                 child: InkWell(
        //                                   onTap: () {
        //                                     if (searchController
        //                                         .text.isNotEmpty) {
        //                                       searchController.clear();
        //                                     } else {
        //                                       setState(() {
        //                                         isSearchOn = false;
        //                                       });
        //                                     }
        //                                   },
        //                                   child: const Icon(
        //                                     CupertinoIcons.xmark_circle_fill,
        //                                     color: Colors.grey,
        //                                     shadows: [
        //                                       Shadow(blurRadius: 0.4)
        //                                     ],
        //                                   ),
        //                                 ),
        //                               ),
        //                             ),
        //                           ),
        //                           SizedBox(height: mq.height * .01),
        //                           Container(
        //                               color: Colors.redAccent, height: 10),
        //                           Container(
        //                             height: mq.height * .1,
        //                             decoration: BoxDecoration(
        //                                 color: Colors.grey.shade200,
        //                                 border: Border.all(
        //                                     color: Colors.black38,
        //                                     width: 0.1),
        //                                 borderRadius: const BorderRadius.all(
        //                                     Radius.circular(18))),
        //                           )
        //                         ],
        //                       ),
        //                     )
        //                   : InkWell(
        //                       onTap: () {
        //                         setState(() {
        //                           isSearchOn = true;
        //                         });
        //                       },
        //                       child: SvgPicture.asset(
        //                           "assets/images/search-svg.svg",
        //                           height: 25),
        //                     ),
        //             ]),
        //             SizedBox(width: mq.width * 0.05),
        //             InkWell(
        //                 onTap: () {},
        //                 child: const Icon(CupertinoIcons.cart, size: 30)),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // ),

        //
        //

        //
//functionalities!

        body: SingleChildScrollView(
          child: Column(
            children: [
              // AddressBox(),
              // ignore: prefer_const_constructors

              // SizedBox(height: mq.width * .05),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: mq.width * .02),
                    const CarouselImage(),
                    SizedBox(height: mq.width * .01),
                    const TopCategories(),
                    // SizedBox(height: mq.width * .01),
                    const DealOfDay(),
                  ],
                ),
              )
            ],
          ),
        ),

        // endDrawer: MyEndDrawer(user: Provider.of<UserProvider>(context).user),
      ),
    );
  }
}

// before undo 10-05-23

//old appbar
        /*
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(mq.height * 0.075),
        //   child: 
          
        //   AppBar(
        //     flexibleSpace: Container(
        //         decoration: const BoxDecoration(
        //             gradient: GlobalVariables.appBarGradient)),
        //     title: Padding(
        //       padding: EdgeInsets.only(top: mq.width * .022),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Expanded(
        //             child: Container(
        //               height: mq.height * .055,
        //               margin: EdgeInsets.only(left: mq.width * .03),
        //               child: Material(
        //                 borderRadius: BorderRadius.circular(mq.width * .025),
        //                 elevation: 1,
        //                 child: TextFormField(
        //                   // when the search field is submitted
        //                   // redirect to search screen, i.e. to the screen
        //                   // with the relevant search query results
        
        //                   onFieldSubmitted: navigateToSearchScreen,
        //                   // textInputAction: TextInputAction.done,
        //                   decoration: InputDecoration(
        //                     filled: true,
        //                     fillColor: Colors.white,
        //                     contentPadding: EdgeInsets.only(top: mq.width * .03),
        //                     border: const OutlineInputBorder(
        //                         borderRadius:
        //                             BorderRadius.all(Radius.circular(7)),
        //                         borderSide: BorderSide.none),
        //                     enabledBorder: const OutlineInputBorder(
        //                         borderRadius:
        //                             BorderRadius.all(Radius.circular(7)),
        //                         borderSide:
        //                             BorderSide(color: Colors.black38, width: 1)),
        //                     // border: null,
        //                     hintText: "Search",
        //                     hintStyle:
        //                         const TextStyle(fontWeight: FontWeight.w400),
        //                     prefixIcon: InkWell(
        //                       onTap: () {},
        //                       child: Padding(
        //                         padding: EdgeInsets.only(left: mq.width * 0.02),
        //                         child:
        //                             const Icon(Icons.search, color: Colors.black),
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ),
        
        //           Container(
        //               color: Colors.transparent,
        //               height: mq.height * .05,
        //               margin: EdgeInsets.symmetric(horizontal: mq.width * .025),
        //               child: const Icon(
        //                 Icons.mic,
        //                 color: Colors.black,
        //                 size: 28,
        //               ))
        
        //           // Text(
        //           //   "${(mq.height * 1).toInt()}",
        //           //   style: TextStyle(fontSize: 18),
        //           // ),
        //           // Text(
        //           //   "${(mq.width).toInt()}",
        //           //   style: TextStyle(fontSize: 18),
        //           // )
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        
        */
       

/*
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:ecommerce_major_project/features/home/services/home_services.dart';
import 'package:ecommerce_major_project/features/home/providers/search_provider.dart';

import '../widgets/address_box.dart';
import '../widgets/carousel_image.dart';
import '../widgets/top_categories.dart';
import '/constants/global_variables.dart';
import '/features/home/widgets/deal_of_day.dart';
import '/features/search/screens/search_screen.dart';
import '/main.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearchOn = false;
  TextEditingController searchController = TextEditingController();

  final historyLength = 5;

  List<String> filteredSearchHistory = [];

  String? selectedTerm;

  HomeServices homeServices = HomeServices();
  List<String>? searchHistoryList = [];
  List<String>? productNames = [];

  List<String>? searchSuggestionsList = [];

  int maxLength = 5;

  bool onChangeActive = false;

  @override
  void initState() {
    super.initState();
    // filteredSearchHistory = filterSearchTerms(filter: null);
    fetchAllProductsNames();
    fetchSearchHistory();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  fetchAllProductsNames() async {
    productNames = await homeServices.fetchAllProductsNames(context);
    setState(() {});
  }

  fetchSearchHistory() async {
    searchHistoryList = await homeServices.fetchSearchHistory(context);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    //make sure to pass the arguments here!
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    print("\n\n================> is onChange active?   ===>  $onChangeActive");
    final searchProvider = Provider.of<SearchProvider>(context);
    // _searchHistory = searchProvider.getSearchlist;
    // print("\n\n==========> Product Names are : $productNames");
    print("\n\n==========> _searchHistoryList : $searchHistoryList");

    mq = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          isSearchOn = false;
        });
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          /*
          // appBar: PreferredSize(
          //   preferredSize: Size.fromHeight(mq.height * 0.075),
          //   child: 
            
          //   AppBar(
          //     flexibleSpace: Container(
          //         decoration: const BoxDecoration(
          //             gradient: GlobalVariables.appBarGradient)),
          //     title: Padding(
          //       padding: EdgeInsets.only(top: mq.width * .022),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Expanded(
          //             child: Container(
          //               height: mq.height * .055,
          //               margin: EdgeInsets.only(left: mq.width * .03),
          //               child: Material(
          //                 borderRadius: BorderRadius.circular(mq.width * .025),
          //                 elevation: 1,
          //                 child: TextFormField(
          //                   // when the search field is submitted
          //                   // redirect to search screen, i.e. to the screen
          //                   // with the relevant search query results
          
          //                   onFieldSubmitted: navigateToSearchScreen,
          //                   // textInputAction: TextInputAction.done,
          //                   decoration: InputDecoration(
          //                     filled: true,
          //                     fillColor: Colors.white,
          //                     contentPadding: EdgeInsets.only(top: mq.width * .03),
          //                     border: const OutlineInputBorder(
          //                         borderRadius:
          //                             BorderRadius.all(Radius.circular(7)),
          //                         borderSide: BorderSide.none),
          //                     enabledBorder: const OutlineInputBorder(
          //                         borderRadius:
          //                             BorderRadius.all(Radius.circular(7)),
          //                         borderSide:
          //                             BorderSide(color: Colors.black38, width: 1)),
          //                     // border: null,
          //                     hintText: "Search",
          //                     hintStyle:
          //                         const TextStyle(fontWeight: FontWeight.w400),
          //                     prefixIcon: InkWell(
          //                       onTap: () {},
          //                       child: Padding(
          //                         padding: EdgeInsets.only(left: mq.width * 0.02),
          //                         child:
          //                             const Icon(Icons.search, color: Colors.black),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          
          //           Container(
          //               color: Colors.transparent,
          //               height: mq.height * .05,
          //               margin: EdgeInsets.symmetric(horizontal: mq.width * .025),
          //               child: const Icon(
          //                 Icons.mic,
          //                 color: Colors.black,
          //                 size: 28,
          //               ))
          
          //           // Text(
          //           //   "${(mq.height * 1).toInt()}",
          //           //   style: TextStyle(fontSize: 18),
          //           // ),
          //           // Text(
          //           //   "${(mq.width).toInt()}",
          //           //   style: TextStyle(fontSize: 18),
          //           // )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          
          */
          // drawer: Drawer(backgroundColor: Colors.redAccent),

          //
          //
          //
          //

          // appBar: PreferredSize(

          //   preferredSize: Size.fromHeight(mq.height * .5),
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: mq.width * .025)
          //         .copyWith(top: mq.height * 0.04),
          //     child: SizedBox(
          //       height: mq.height * .15,
          //       child: Padding(
          //         padding: EdgeInsets.only(right: mq.width * .03),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.end,
          //           children: [
          //             Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          //               isSearchOn
          //                   ? SizedBox(
          //                       width: mq.width * .75,
          //                       child: Column(
          //                         // mainAxisAlignment: MainAxisAlignment.center,
          //                         children: [
          //                           TextFormField(
          //                             controller: searchController,
          //                             autofocus: true,
          //                             cursorColor: Colors.grey.shade800,
          //                             onChanged: (val) {},
          //                             // when the search field is submitted
          //                             // redirect to search screen, i.e. to the screen
          //                             // with the relevant search query results
          //                             onFieldSubmitted: navigateToSearchScreen,
          //                             // textInputAction: TextInputAction.done,
          //                             decoration: InputDecoration(
          //                               filled: true,
          //                               fillColor: Colors.grey.shade200,
          //                               contentPadding: EdgeInsets.only(
          //                                   top: mq.width * .03),
          //                               border: const OutlineInputBorder(
          //                                   borderRadius: BorderRadius.all(
          //                                       Radius.circular(18)),
          //                                   borderSide: BorderSide(
          //                                       color: Colors.black38,
          //                                       width: 0.1)),
          //                               enabledBorder: const OutlineInputBorder(
          //                                   borderRadius: BorderRadius.all(
          //                                       Radius.circular(18)),
          //                                   borderSide: BorderSide(
          //                                       color: Colors.black38,
          //                                       width: 0.1)),
          //                               focusedBorder: const OutlineInputBorder(
          //                                   borderRadius: BorderRadius.all(
          //                                       Radius.circular(18)),
          //                                   borderSide: BorderSide(
          //                                       color: Colors.black38,
          //                                       width: 0.1)),
          //                               // border: null,
          //                               hintText: "Search",
          //                               hintStyle: const TextStyle(
          //                                   fontWeight: FontWeight.w300),
          //                               prefixIcon: Padding(
          //                                 padding: const EdgeInsets.all(15.0),
          //                                 child: SvgPicture.asset(
          //                                   "assets/images/search-svg.svg",
          //                                   height: 10,
          //                                   // width: 2,
          //                                 ),
          //                               ),
          //                               suffixIcon: Padding(
          //                                 padding: const EdgeInsets.all(15.0),
          //                                 child: InkWell(
          //                                   onTap: () {
          //                                     if (searchController
          //                                         .text.isNotEmpty) {
          //                                       searchController.clear();
          //                                     } else {
          //                                       setState(() {
          //                                         isSearchOn = false;
          //                                       });
          //                                     }
          //                                   },
          //                                   child: const Icon(
          //                                     CupertinoIcons.xmark_circle_fill,
          //                                     color: Colors.grey,
          //                                     shadows: [
          //                                       Shadow(blurRadius: 0.4)
          //                                     ],
          //                                   ),
          //                                 ),
          //                               ),
          //                             ),
          //                           ),
          //                           SizedBox(height: mq.height * .01),
          //                           Container(
          //                               color: Colors.redAccent, height: 10),
          //                           Container(
          //                             height: mq.height * .1,
          //                             decoration: BoxDecoration(
          //                                 color: Colors.grey.shade200,
          //                                 border: Border.all(
          //                                     color: Colors.black38,
          //                                     width: 0.1),
          //                                 borderRadius: const BorderRadius.all(
          //                                     Radius.circular(18))),
          //                           )
          //                         ],
          //                       ),
          //                     )
          //                   : InkWell(
          //                       onTap: () {
          //                         setState(() {
          //                           isSearchOn = true;
          //                         });
          //                       },
          //                       child: SvgPicture.asset(
          //                           "assets/images/search-svg.svg",
          //                           height: 25),
          //                     ),
          //             ]),
          //             SizedBox(width: mq.width * 0.05),
          //             InkWell(
          //                 onTap: () {},
          //                 child: const Icon(CupertinoIcons.cart, size: 30)),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          //
          //
          //
          //
          //
          body: Container(
            padding: EdgeInsets.only(top: mq.height * .08),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: mq.width * .03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isSearchOn
                          ? SizedBox(
                              width: mq.width * .75,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: searchController,
                                    autofocus: true,
                                    cursorColor: Colors.grey.shade800,
                                    onChanged: (val) {
                                      if (searchController.text == "") {
                                        setState(() {
                                          onChangeActive = false;
                                        });
                                      } else {
                                        setState(() {
                                          onChangeActive = true;
                                        });
                                        searchSuggestionsList =
                                            searchProvider.getSugggetions;
                                        for (int i = 0;
                                            i < productNames!.length;
                                            i++) {
                                          // print("\n inside the for loop");
                                          bool isItemPresent = productNames![i]
                                              .toLowerCase()
                                              .startsWith(val.toLowerCase());
                                          if (isItemPresent &&
                                              !searchSuggestionsList!
                                                  .contains(productNames![i])) {
                                            searchProvider.addToSuggestions(
                                                productNames![i]);
                                            print(
                                                " \n\n\nSuggestionList is matching ===> : ${searchProvider.getSugggetions}");
                                          } else if (!isItemPresent &&
                                              searchSuggestionsList!
                                                  .contains(productNames![i])) {
                                            searchProvider
                                                .removeFromSuggestions(
                                                    productNames![i]);
                                          }
                                        }
                                      }
                                    },
                                    // when the search field is submitted
                                    // redirect to search screen, i.e. to the screen
                                    // with the relevant search query results
                                    onFieldSubmitted: (query) {
                                      if (query.trim().isNotEmpty) {
                                        navigateToSearchScreen(query.trim());

                                        // _searchHistory.add(query);
                                        // searchProvider.setSearchItem(query);

                                        if (!searchHistoryList!
                                            .contains(query.trim())) {
                                          print(
                                              " \n\n =======> search history does not contain this query....add it!");
                                          if (searchHistoryList!.length <
                                              maxLength) {
                                            homeServices.setSearchHistory(
                                              context: context,
                                              searchQuery: query.trim(),
                                            );
                                            print(
                                                " \n\n =======> query added....!");
                                          } else if (searchHistoryList!
                                                  .length ==
                                              maxLength) {
                                            setState(() {
                                              homeServices
                                                  .deleteSearchHistoryItem(
                                                      context: context,
                                                      deleteQuery:
                                                          searchHistoryList![
                                                              0]);
                                              // searchHistoryList!.removeAt(0);
                                              homeServices.setSearchHistory(
                                                  context: context,
                                                  searchQuery: query.trim());
                                              // searchHistoryList!
                                              //     .add(query.trim());
                                            });
                                            print(
                                                " \n\n =======> query added....!");
                                          }
                                        }
                                        isSearchOn = false;
                                        searchController.clear();
                                      } else {}
                                    },
                                    // textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      // contentPadding:
                                      //     EdgeInsets.only(top: mq.width * .03),
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18)),
                                          borderSide: BorderSide(
                                              color: Colors.black38,
                                              width: 0.1)),
                                      enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18)),
                                          borderSide: BorderSide(
                                              color: Colors.black38,
                                              width: 0.1)),
                                      focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18)),
                                          borderSide: BorderSide(
                                              color: Colors.black38,
                                              width: 0.1)),
                                      // border: null,
                                      hintText: "Search",
                                      hintStyle: const TextStyle(
                                          fontWeight: FontWeight.w300),
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: SvgPicture.asset(
                                          "assets/images/search-svg.svg",
                                          height: 10,
                                          // width: 2,
                                        ),
                                      ),
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: InkWell(
                                          onTap: () {
                                            if (searchController
                                                .text.isNotEmpty) {
                                              searchController.clear();
                                            } else {
                                              setState(() {
                                                isSearchOn = false;
                                              });
                                            }
                                          },
                                          child: Icon(
                                            CupertinoIcons.xmark_circle_fill,
                                            color: Colors.grey,
                                            shadows: [Shadow(blurRadius: 0.4)],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: mq.height * .01),
                                  // Container(
                                  //     color: Colors.redAccent, height: 10),
                                  // Container(
                                  //   height: mq.height * .1,
                                  //   decoration: BoxDecoration(
                                  //       color: Colors.grey.shade200,
                                  //       border: Border.all(
                                  //           color: Colors.black38, width: 0.1),
                                  //       borderRadius: const BorderRadius.all(
                                  //           Radius.circular(18))),
                                  // ),
                                  SizedBox(
                                    height: mq.height * 0.35,
                                    child: searchHistoryList == null
                                        ? const SizedBox.shrink(
                                            child: Text("No history found"),
                                          )
                                        : onChangeActive
                                            ? ListView.builder(
                                                padding: EdgeInsets.zero,
                                                itemCount: min(
                                                    searchProvider
                                                        .getSugggetions!.length,
                                                    5),
                                                itemBuilder: (context, index) {
                                                  String listTitle =
                                                      searchProvider
                                                          .getSugggetions!
                                                          .toList()[index]
                                                          .trim();
                                                  return ListTile(
                                                    onTap: () {
                                                      // print(
                                                      //     "\nQuery to be searched ====>  ${searchHistoryList![index]}");
                                                      navigateToSearchScreen(
                                                          listTitle);
//complete this duplicate entries are also coming
//moreover when the search item from productNames list is clicked add it to history

// trim() every query!

                                                      // if (!searchHistoryList!
                                                      //     .contains(
                                                      //         searchController
                                                      //             .text
                                                      //             .trim())) {
                                                      //   homeServices
                                                      //       .setSearchHistory(
                                                      //     context: context,
                                                      //     searchQuery:
                                                      // searchController
                                                      //     .text
                                                      //     .trim(),
                                                      //   );
                                                      // }

                                                      if (searchHistoryList!
                                                              .length <
                                                          maxLength) {
                                                        homeServices
                                                            .setSearchHistory(
                                                          context: context,
                                                          searchQuery:
                                                              listTitle,
                                                        );
                                                      } else if (searchHistoryList!
                                                              .length ==
                                                          maxLength) {
                                                        print(
                                                            "\n\n====> max length reached...");
                                                        setState(() {
                                                          homeServices
                                                              .deleteSearchHistoryItem(
                                                                  context:
                                                                      context,
                                                                  deleteQuery:
                                                                      searchHistoryList![
                                                                          0]);
                                                          // searchHistoryList!.removeAt(0);
                                                          homeServices
                                                              .setSearchHistory(
                                                                  context:
                                                                      context,
                                                                  searchQuery:
                                                                      listTitle);
                                                          // searchHistoryList!
                                                          //     .add(query.trim());
                                                        });
                                                      }

                                                      isSearchOn = false;
                                                      searchController.clear();
                                                    },
                                                    title: Text(listTitle),
                                                    // contentPadding: EdgeInsets.zero,
                                                    leading: const Icon(
                                                      Icons
                                                          .arrow_outward_rounded,
                                                      color: Colors.grey,
                                                      shadows: [
                                                        Shadow(blurRadius: 0.4)
                                                      ],
                                                    ),
                                                    tileColor:
                                                        Colors.grey.shade100,
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  18)),
                                                    ),
                                                  );
                                                },
                                              )
                                            : ListView.builder(
                                                padding: EdgeInsets.zero,
                                                itemCount: min(maxLength,
                                                    searchHistoryList!.length),
                                                itemBuilder: (context, index) {
                                                  String listTitle =
                                                      searchHistoryList!
                                                          .reversed
                                                          .toList()[index]
                                                          .trim();
                                                  return ListTile(
                                                    onTap: () {
                                                      print(
                                                          "\n\n=====> name of the item tapped : $listTitle");
                                                      // print(
                                                      //     "\nQuery to be searched ====>  ${searchHistoryList![index]}");

                                                      //remove from the list
                                                      print(
                                                          "\n\n ======> Search history before delete list : $searchHistoryList");

                                                      print(
                                                          "\n\ndeleting listtitle ===> : $listTitle");

                                                      // delete and add working individually but not together!!!
                                                      //

                                                      homeServices
                                                          .deleteSearchHistoryItem(
                                                              context: context,
                                                              deleteQuery:
                                                                  listTitle);
                                                      print(
                                                          "\n\ndeleted listtitle ===> : $listTitle");
                                                      print("\n\n\n");
                                                      // print(
                                                      //     "\n\nadding listtitle ===> : $listTitle");

                                                      // homeServices
                                                      //     .setSearchHistory(
                                                      //         context: context,
                                                      //         searchQuery:
                                                      //             listTitle);
                                                      print(
                                                          "\nfetching search history....${homeServices.fetchSearchHistory(context).then(
                                                        (value) {
                                                          print(
                                                              "======>updated list is $value");
                                                        },
                                                      )}");
                                                      // print(
                                                      //     "\n\nadding listtitle ===> : $listTitle");
                                                      // print(
                                                      //     "\n\n Adding orange ..........");

                                                      // homeServices
                                                      //     .fetchSearchHistory(
                                                      //         context);
                                                      print(
                                                          "\n\n ======> Search history after delete list  : $searchHistoryList");

                                                      //add in the list again to rank higher

                                                      // searchHistoryList!
                                                      //     .removeWhere(
                                                      //         (item) =>
                                                      //             item ==
                                                      //             listTitle);

                                                      // searchHistoryList!
                                                      //     .add(listTitle);

                                                      navigateToSearchScreen(
                                                          listTitle);
                                                    },
                                                    title: Text(listTitle),
                                                    // contentPadding: EdgeInsets.zero,
                                                    leading: const Icon(
                                                      Icons.history_rounded,
                                                      color: Colors.grey,
                                                      shadows: [
                                                        Shadow(blurRadius: 0.4)
                                                      ],
                                                    ),
                                                    trailing: InkWell(
                                                      onTap: () {
                                                        setState(
                                                          () {
                                                            homeServices
                                                                .deleteSearchHistoryItem(
                                                                    context:
                                                                        context,
                                                                    deleteQuery:
                                                                        listTitle);
                                                          },
                                                        );
                                                      },
                                                      child: const Icon(
                                                        CupertinoIcons.xmark,
                                                        size: 16,
                                                        color: Colors.grey,
                                                        shadows: [
                                                          Shadow(
                                                              blurRadius: 0.4)
                                                        ],
                                                      ),
                                                    ),
                                                    tileColor:
                                                        Colors.grey.shade100,
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  18)),
                                                    ),
                                                  );
                                                },
                                              ),
                                  )
                                ],
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  isSearchOn = true;
                                });
                              },
                              child: SvgPicture.asset(
                                  "assets/images/search-svg.svg",
                                  height: 25),
                            ),
                      SizedBox(width: mq.width * 0.05),
                      InkWell(
                          onTap: () {},
                          child: const Icon(CupertinoIcons.cart, size: 30)),
                    ],
                  ),
                ),

                // ignore: prefer_const_constructors
                // AddressBox(),
                // //
                // SizedBox(height: mq.width * .02),
                // // ignore: prefer_const_constructors
                // TopCategories(),
                // SizedBox(height: mq.width * .04),
                // const CarouselImage(),
                // SizedBox(height: mq.width * .02),
                // const DealOfDay()
              ],
            ),
          ),
        ),
      ),
    );
  }
}







 */

// List<String> filterSearchTerms({required String? filter}) {
//   if (filter != null && filter.isNotEmpty) {
//     return _searchHistory.reversed
//         .where((term) => term.startsWith(filter))
//         .toList();
//   } else {
//     return _searchHistory.reversed.toList();
//   }
// }

// void addSearchTerm(String term) {
//   if (_searchHistory.contains(term)) {
//     putSearchTermFirst(term);
//     return;
//   }
//   _searchHistory.add(term);
//   if (_searchHistory.length > historyLength) {
//     _searchHistory.removeRange(0, _searchHistory.length - historyLength);
//   }

//   filteredSearchHistory = filterSearchTerms(filter: null);
// }

// void deleteSearchTerm(String term) {
//   _searchHistory.removeWhere((t) => t == term);
//   filteredSearchHistory = filterSearchTerms(filter: null);
// }

// void putSearchTermFirst(String term) {
//   deleteSearchTerm(term);
//   addSearchTerm(term);
// }

//SearchDelegate
/*
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(mq.height * .1),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.width * .025)
                  .copyWith(top: mq.height * 0.04),
              child: SizedBox(
                height: mq.height * .15,
                child: Padding(
                  padding: EdgeInsets.only(right: mq.width * .03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        // isSearchOn
                        //     ? SizedBox(
                        //         width: mq.width * .75,
                        //         child: TextFormField(
                        //           autofocus: true,
                        //           cursorColor: Colors.grey.shade800,
                        //           // when the search field is submitted
                        //           // redirect to search screen, i.e. to the screen
                        //           // with the relevant search query results
                        //           onFieldSubmitted: navigateToSearchScreen,
                        //           // textInputAction: TextInputAction.done,
                        //           decoration: InputDecoration(
                        //             filled: true,
                        //             fillColor: Colors.white,
                        //             contentPadding:
                        //                 EdgeInsets.only(top: mq.width * .03),
                        //             border: const OutlineInputBorder(
                        //                 borderRadius: BorderRadius.all(
                        //                     Radius.circular(15)),
                        //                 borderSide: BorderSide(
                        //                     color: Colors.black38, width: 0.4)),
                        //             enabledBorder: const OutlineInputBorder(
                        //                 borderRadius: BorderRadius.all(
                        //                     Radius.circular(15)),
                        //                 borderSide: BorderSide(
                        //                     color: Colors.black38, width: 0.4)),
                        //             focusedBorder: const OutlineInputBorder(
                        //                 borderRadius: BorderRadius.all(
                        //                     Radius.circular(15)),
                        //                 borderSide: BorderSide(
                        //                     color: Colors.black38, width: 0.4)),
                        //             // border: null,
                        //             hintText: "Search",
                        //             hintStyle: const TextStyle(
                        //                 fontWeight: FontWeight.w300),
                        //             // prefixIcon: Padding(
                        //             //   padding: const EdgeInsets.all(15.0),
                        //             //   child: SvgPicture.asset(
                        //             //     "assets/images/search-svg.svg",
                        //             //     height: 10,
                        //             //     // width: 2,
                        //             //   ),
                        //             // ),
                        //             // suffixIcon: Padding(
                        //             //   padding: const EdgeInsets.all(15.0),
                        //             //   child: InkWell(
                        //             //     onTap: () {
                        //             //       setState(() {
                        //             //         isSearchOn = false;
                        //             //       });
                        //             //     },
                        //             //     child: const Icon(
                        //             //       CupertinoIcons.xmark_circle_fill,
                        //             //       color: Colors.grey,
                        //             //       shadows: [Shadow(blurRadius: 0.4)],
                        //             //     ),
                        //             //   ),
                        //             // ),
                        //           ),
                        //         ),
                        //       )
                        // :
                        InkWell(
                          onTap: () {
                            // setState(() {
                            //   isSearchOn = true;
                            // });
                            showSearch(
                                context: context, delegate: MySearchDelegate());
                          },
                          child: SvgPicture.asset(
                              "assets/images/search-svg.svg",
                              height: 25),
                        ),
                      ]),
                      SizedBox(width: mq.width * 0.05),
                      InkWell(
                          onTap: () {},
                          child: const Icon(CupertinoIcons.cart, size: 30)),
                    ],
                  ),
                ),
              ),
            ),
          ),

*/

/*

*/

/* 

// import 'package:flutter/material.dart';
// import '../widgets/address_box.dart';
// import '../widgets/top_categories.dart';
// import '../widgets/carousel_image.dart';
// import '/constants/global_variables.dart';
// import '/features/home/widgets/deal_of_day.dart';
// import '/features/search/screens/search_screen.dart';
// import '/main.dart';

// class HomeScreen extends StatefulWidget {
//   static const String routeName = '/home';
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   void navigateToSearchScreen(String query) {
//     //make sure to pass the arguments here!
//     Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(mq.height * 0.075),
//         child: AppBar(
//           flexibleSpace: Container(
//               decoration: const BoxDecoration(
//                   gradient: GlobalVariables.appBarGradient)),
//           title: Padding(
//             padding: EdgeInsets.only(top: mq.width * .022),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Container(
//                     height: mq.height * .055,
//                     margin: EdgeInsets.only(left: mq.width * .03),
//                     child: Material(
//                       borderRadius: BorderRadius.circular(mq.width * .025),
//                       elevation: 1,
//                       child: TextFormField(
//                         // when the search field is submitted
//                         // redirect to search screen, i.e. to the screen
//                         // with the relevant search query results

//                         onFieldSubmitted: navigateToSearchScreen,
//                         // textInputAction: TextInputAction.done,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Colors.white,
//                           contentPadding: EdgeInsets.only(top: mq.width * .03),
//                           border: const OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(7)),
//                               borderSide: BorderSide.none),
//                           enabledBorder: const OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(7)),
//                               borderSide:
//                                   BorderSide(color: Colors.black38, width: 1)),
//                           // border: null,
//                           hintText: "Search",
//                           hintStyle:
//                               const TextStyle(fontWeight: FontWeight.w400),
//                           prefixIcon: InkWell(
//                             onTap: () {},
//                             child: Padding(
//                               padding: EdgeInsets.only(left: mq.width * 0.02),
//                               child:
//                                   const Icon(Icons.search, color: Colors.black),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 Container(
//                     color: Colors.transparent,
//                     height: mq.height * .05,
//                     margin: EdgeInsets.symmetric(horizontal: mq.width * .025),
//                     child: const Icon(
//                       Icons.mic,
//                       color: Colors.black,
//                       size: 28,
//                     ))

//                 // Text(
//                 //   "${(mq.height * 1).toInt()}",
//                 //   style: TextStyle(fontSize: 18),
//                 // ),
//                 // Text(
//                 //   "${(mq.width).toInt()}",
//                 //   style: TextStyle(fontSize: 18),
//                 // )
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // ignore: prefer_const_constructors
//             AddressBox(),
//             SizedBox(height: mq.width * .02),
//             // ignore: prefer_const_constructors
//             TopCategories(),
//             SizedBox(height: mq.width * .02),
//             const CarouselImage(),
//             SizedBox(height: mq.width * .02),
//             const DealOfDay()
//           ],
//         ),
//       ),
//     );
//   }
// }

*/
