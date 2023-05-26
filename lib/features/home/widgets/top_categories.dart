import 'dart:math';

import 'package:ecommerce_major_project/features/cart/screens/cart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';

import 'package:ecommerce_major_project/common/widgets/color_loader_2.dart';
import 'package:ecommerce_major_project/common/widgets/loader.dart';
import 'package:ecommerce_major_project/constants/utils.dart';
import 'package:ecommerce_major_project/features/home/screens/wish_list_screen.dart';
import 'package:ecommerce_major_project/features/home/services/home_services.dart';
import 'package:ecommerce_major_project/features/product_details/screens/product_detail_screen.dart';
import 'package:ecommerce_major_project/features/product_details/services/product_detail_services.dart';
import 'package:ecommerce_major_project/models/product.dart';

import '/constants/global_variables.dart';
import '/features/home/screens/category_deals_screen.dart';
import '/main.dart';

// Route _createRoute(dynamic className) {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => className,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(0.0, 1.0);
//       const end = Offset.zero;
//       const curve = Curves.decelerate;

//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       return SlideTransition(position: animation.drive(tween), child: child);
//     },
//   );
// }

class TopCategories extends StatefulWidget {
  const TopCategories({super.key});

  @override
  State<TopCategories> createState() => _TopCategoriesState();
}

class _TopCategoriesState extends State<TopCategories>
    with TickerProviderStateMixin {
  // tabbar variables
  int activeTabIndex = 0;
  late final TabController _tabController;
  final int _tabLength = 5;

  // final ScrollController controller = ScrollController();

  //products
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();
  final ProductDetailServices productDetailServices = ProductDetailServices();
  //add to cart function copied, link it to the gridview items buttons

  List<String> categoriesList = [
    "Mobiles",
    "Essentials",
    "Appliances",
    "Books",
    "Fashion",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabLength, vsync: this);
    fetchCategoryProducts(categoriesList[activeTabIndex]);
  }

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDealsScreen.routeName,
        arguments: category);
  }

  void addToCart(String productName, Product product) {
    print("Triggered add to cart <====");
    print("Product is  : $productName");
    productDetailServices.addToCart(context: context, product: product);
    print("Execution finished add to cart <====");
  }

  fetchCategoryProducts(String categoryName) async {
    productList = await homeServices.fetchCategoryProducts(
      context: context,
      category: categoryName,
    );
    setState(() {});
    print("\n\n =======> Product List is :  =======> ${productList![0].name}");
  }

  // fetchCategoryProducts() async {
  //   productList = await homeServices.fetchCategoryProducts(
  //     context: context,
  //     category: widget.category,
  //   );
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Container(
      // foregroundDecoration:
      //     BoxDecoration(color: Colors.grey.shade100.withOpacity(0.2)),
      // color: Colors.redAccent,
      // margin: EdgeInsets.symmetric(horizontal: 20),
      height: mq.height * .52,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DefaultTabController(
            length: _tabLength,
            child: Container(
              // color: Colors.cyan,
              height: mq.height * .07,
              // height: mq.height * .1,
              width: double.infinity,
              child: TabBar(
                controller: _tabController,
                onTap: (index) {
                  setState(() {
                    activeTabIndex = index;
                  });
                  if (productList == null) {
                    fetchCategoryProducts(categoriesList[activeTabIndex]);
                  }
                },
                // labelPadding: const EdgeInsets.all(5),
                physics: const BouncingScrollPhysics(),
                splashBorderRadius: BorderRadius.circular(15),
                indicatorWeight: 1,
                indicatorColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.zero,
                // splashFactory: NoSplash.splashFactory,
                // dividerColor: Colors.transparent,
                // indicatorColor: Colors.transparent,
                // indicator: BoxDecoration(
                //   color: Colors.black,
                //   borderRadius: BorderRadius.circular(20),
                //   shape: BoxShape.rectangle,
                // ),
                isScrollable: true,
                // labelColor: Colors.blueGrey,
                // unselectedLabelColor: Colors.redAccent,
                tabs: [
                  for (int index = 0; index < _tabLength; index++)
                    Tab(
                      child: SizedBox(
                        height: mq.height * .06,
                        // width: 140,
                        child: Card(
                          margin: EdgeInsets.symmetric(
                            horizontal: mq.width * .01,
                          ),
                          color: activeTabIndex == index
                              ? Colors.black87
                              : Colors.grey.shade50,
                          elevation: .8,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: GlobalVariables.primaryGreyTextColor,
                                  width: 0.1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    GlobalVariables.categoryImages[index]
                                        ['image']!,
                                    height: 30,
                                    // ignore: deprecated_member_use
                                    color: activeTabIndex == index
                                        ? Colors.white
                                        : Colors.grey.shade700,
                                  ),
                                  SizedBox(width: mq.width * .015),
                                  Text(
                                    GlobalVariables.categoryImages[index]
                                        ['title']!,
                                    style: TextStyle(
                                      color: activeTabIndex == index
                                          ? Colors.white
                                          : Colors.grey.shade700,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          NotificationListener(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollEndNotification) {
                _onTabChanged();
              }
              return false;
            },
            child: Container(
              // height: 400, //height of TabBarView
              //height of the GridView
              height: mq.height * 0.45,
              // decoration: const BoxDecoration(
              //   border: Border(
              //     top: BorderSide(color: Colors.grey, width: 0.5),
              //   ),
              // ),
              child: TabBarView(
                controller: _tabController,
                children: [
                  //
                  for (int i = 0; i < _tabLength; i++)
                    Container(
                      height: mq.height * 0.3,
                      decoration: BoxDecoration(
                          // color: Colors.cyanAccent,
                          border: Border(
                              top: BorderSide(
                                  color: Colors.grey.shade700, width: 0.4))),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // See all button
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: mq.height * .008)
                                    .copyWith(right: mq.height * .015),
                            child: InkWell(
                              onTap: () {
                                navigateToCategoryPage(
                                    context, categoriesList[activeTabIndex]);
                              },
                              child: Text("See All",
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),

                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    color: Colors.grey.shade200, width: 0.5),
                                bottom: BorderSide(
                                    color: Colors.grey.shade700, width: 0.4),
                              ),
                            ),
                            // color: Colors.cyan,
                            height: mq.height * 0.4,
                            //
                            //
                            //
                            //
                            //
                            child: productList == null
                                ? const ColorLoader2()
                                : productList!.isEmpty
                                    ? const Center(
                                        child: Text("No item to fetch"))
                                    : GridView.builder(
                                        scrollDirection: Axis.vertical,
                                        physics: BouncingScrollPhysics(),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: mq.width * .04,
                                        ),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 0.72,
                                          mainAxisSpacing: 15,
                                          crossAxisSpacing: 15,
                                        ),
                                        itemCount: min(productList!.length, 4),
                                        itemBuilder: (context, index) {
                                          Product product = productList![index];
                                          bool isProductAvailable =
                                              productList![index].quantity == 0;
                                          print(
                                              "\n\n============> product category : ${categoriesList[activeTabIndex]}");
                                          return Stack(
                                            alignment:
                                                AlignmentDirectional.topEnd,
                                            children: [
                                              Card(
                                                color: Color.fromARGB(
                                                    255, 254, 252, 255),
                                                elevation: 2.5,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          mq.width * .025,
                                                      vertical: mq.width * .02),
                                                  child: Column(
                                                    // crossAxisAlignment:
                                                    //     CrossAxisAlignment.stretch,
                                                    children: [
                                                      // navigate to product details screen
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.pushNamed(
                                                            context,
                                                            ProductDetailScreen
                                                                .routeName,
                                                            arguments: product,
                                                          );
                                                        },
                                                        child: Container(
                                                          // color: Colors.redAccent,
                                                          // width: double.infinity,
                                                          height:
                                                              mq.height * .15,
                                                          width: mq.width * .4,
                                                          child: Image.network(
                                                            // "https://rukminim1.flixcart.com/image/416/416/xif0q/computer/e/k/k/-original-imagg5jsxzthfd39.jpeg?q=70",
                                                            //iphone
                                                            // "https://rukminim1.flixcart.com/image/416/416/ktketu80/mobile/8/z/w/iphone-13-mlph3hn-a-apple-original-imag6vzzhrxgazsg.jpeg?q=70",
                                                            product.images[0],

                                                            //TV
                                                            // "https://rukminim1.flixcart.com/image/416/416/kiyw9e80-0/television/p/0/w/32path0011-thomson-original-imafynyvsmeuwtzr.jpeg?q=70",
                                                            // width: mq.width * .2,
                                                            // height: mq.height * .15,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height:
                                                              mq.height * .005),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: Text(
                                                          product.name,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        // color: Colors.blueAccent,
                                                        child: Text(
                                                          "₹ ${product.price.toStringAsFixed(2)}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          TextButton.icon(
                                                            style: TextButton.styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                backgroundColor:
                                                                    Colors.grey
                                                                        .shade200),
                                                            onPressed: () {
                                                              homeServices
                                                                  .addToWishList(
                                                                      context:
                                                                          context,
                                                                      product:
                                                                          product);
                                                              showSnackBar(
                                                                  context:
                                                                      context,
                                                                  text:
                                                                      "Added to WishList",
                                                                  onTapFunction:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(GlobalVariables.createRoute(
                                                                            WishListScreen()));
                                                                    // Navigator.push(
                                                                    //     context,
                                                                    //     MaterialPageRoute(
                                                                    //         builder: (_) =>
                                                                    //             WishListScreen()));

                                                                    // List<Product>?
                                                                    //     wishList =
                                                                    //     await homeServices
                                                                    //         .fetchWishList(
                                                                    //             context)
                                                                    //         .then(
                                                                    //             (wishList) {
                                                                    //   Navigator.push(
                                                                    //       context,
                                                                    //       MaterialPageRoute(
                                                                    //           builder: (context) =>
                                                                    //               WishListScreen(wishList: wishList)));
                                                                    //   return null;
                                                                    // });
                                                                  },
                                                                  actionLabel:
                                                                      "View");
                                                            },
                                                            icon: const Icon(
                                                                CupertinoIcons
                                                                    .add,
                                                                size: 18,
                                                                color: Colors
                                                                    .black87),
                                                            label: const Text(
                                                                "WishList",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black87)),
                                                          ),
                                                          Container(
                                                            child: InkWell(
                                                                onTap:
                                                                    isProductAvailable
                                                                        ? () {
                                                                            showSnackBar(
                                                                                context: context,
                                                                                text: "Product out of stock",
                                                                                actionLabel: "View",
                                                                                onTapFunction: () {
                                                                                  Navigator.of(context).push(GlobalVariables.createRoute(CartScreen()));
                                                                                });
                                                                          }
                                                                        : () {
                                                                            addToCart(product.name,
                                                                                product);
                                                                            showSnackBar(
                                                                                context: context,
                                                                                text: "Added to cart");
                                                                          },
                                                                // onTap: () {
                                                                //   addToCart(
                                                                //       product
                                                                //           .name,
                                                                //       product);
                                                                //   showSnackBar(
                                                                //       context:
                                                                //           context,
                                                                //       text:
                                                                //           "Added to cart!");
                                                                // },
                                                                child: const Icon(
                                                                    CupertinoIcons
                                                                        .cart_badge_plus,
                                                                    size: 35)),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              // LikeButton(
                                              //   bubblesSize: 10,
                                              //   circleSize: 10,
                                              //   circleColor: CircleColor(
                                              //       start: Colors.purpleAccent,
                                              //       end: Colors.indigoAccent),
                                              //   likeCountAnimationDuration:
                                              //       Duration(seconds: 2),
                                              //   padding: EdgeInsets.only(
                                              //       right: mq.width * .03,
                                              //       top: mq.width * .03),
                                              //   crossAxisAlignment:
                                              //       CrossAxisAlignment.start,
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment.end,
                                              //   animationDuration:
                                              //       Duration(seconds: 1),
                                              //   size: 22,
                                              // ),

                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 10, right: 10),
                                                  padding: EdgeInsets.all(3),
                                                  // height: 30,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.grey,
                                                          shape:
                                                              BoxShape.circle),
                                                  child: const Icon(
                                                      Icons.favorite,
                                                      color: Colors.white,
                                                      size: 16),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),

      //GridView widget
      /*
  
    GridView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: mq.width * .025,
                            vertical: mq.width * .0125),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                        ),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Card(
                              color: Color.fromARGB(255, 254, 252, 255),
                              elevation: 2.5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: mq.width * .025,
                                    vertical: mq.width * .0125),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height: mq.height * .15,
                                      child: Image.network(
                                        "https://rukminim1.flixcart.com/image/416/416/ktketu80/mobile/6/n/d/iphone-13-mlpg3hn-a-apple-original-imag6vpyghayhhrh.jpeg?q=70",
                                        height: mq.height * 0.15,
                                        // fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    SizedBox(height: mq.height * .01),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        "Iphone 128GB | 8 GB RAM Crystal White | Realease New",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      // color: Colors.blueAccent,
                                      child: Text(
                                        "\$99.992",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Icon(
                                            CupertinoIcons.cart_badge_plus,
                                            size: 35),
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        }),
                   
   */

      //SizedBox category

      /*
  
  Tab(
                      child: 
                      SizedBox(
                        height: mq.height * .06,
                        child: Card(
                          margin: EdgeInsets.symmetric(
                            horizontal: mq.width * .02,
                          ),
                          color: activeTabIndex == index
                              ? Colors.black87
                              : Colors.grey.shade50,
                          elevation: .8,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: GlobalVariables.primaryGreyTextColor,
                                  width: 0.1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    GlobalVariables.categoryImages[index]
                                        ['image']!,
                                    height: 30,
                                    color: activeTabIndex == index
                                        ? Colors.white
                                        : Colors.grey.shade700,
                                  ),
                                  SizedBox(width: mq.width * .015),
                                  Text(
                                    GlobalVariables.categoryImages[index]
                                        ['title']!,
                                    style: TextStyle(
                                      color: activeTabIndex == index
                                          ? Colors.white
                                          : Colors.grey.shade700,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ),
            
   */

      //ListView.builder
      /*
      
      ListView.builder(
        itemCount: GlobalVariables.categoryImages.length,
        scrollDirection: Axis.horizontal,
        itemExtent: mq.width * .4,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () => navigateToCategoryPage(
                    //the context is not included
                    context, GlobalVariables.categoryImages[index]['title']!,
                  ),
              child: Card(
                margin: EdgeInsets.symmetric(
                    horizontal: mq.width * .02, vertical: mq.width * 0.01),
                color: Colors.grey.shade50,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: GlobalVariables.primaryGreyTextColor,
                        width: 0.1),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                          GlobalVariables.categoryImages[index]['image']!,
                          height: 30),
                      SizedBox(width: mq.width * .03),
                      Text(
                        GlobalVariables.categoryImages[index]['title']!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ]),
              )
              /*
              Card(
                elevation: 3,
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        GlobalVariables.categoryImages[index]['image']!,
                        fit: BoxFit.cover,
                        height: mq.width * .1,
                        width: mq.width * .1,
                      ),
                    ),
                  ),
                  Text(
                    GlobalVariables.categoryImages[index]['title']!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ]),
              ),
              */

              );
        },
      ),
    */
    );
  }

  void _onTabChanged() {
    switch (_tabController.index) {
      case 0:
        // handle 0 position
        activeTabIndex = 0;
        fetchCategoryProducts(categoriesList[activeTabIndex]);
        break;

      case 1:
        activeTabIndex = 1;
        fetchCategoryProducts(categoriesList[activeTabIndex]);
        // handle 1 position
        break;

      case 2:
        activeTabIndex = 2;
        fetchCategoryProducts(categoriesList[activeTabIndex]);
        // handle 1 position
        break;

      case 3:
        activeTabIndex = 3;
        fetchCategoryProducts(categoriesList[activeTabIndex]);
        break;

      case 4:
        activeTabIndex = 4;
        fetchCategoryProducts(categoriesList[activeTabIndex]);
        break;
    }
  }
}
