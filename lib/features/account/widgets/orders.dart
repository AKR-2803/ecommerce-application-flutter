import 'package:flutter/material.dart';

import 'package:ecommerce_major_project/main.dart';
import 'package:ecommerce_major_project/models/order.dart';
import 'package:ecommerce_major_project/common/widgets/bottom_bar.dart';
import 'package:ecommerce_major_project/constants/global_variables.dart';
import 'package:ecommerce_major_project/common/widgets/color_loader_2.dart';
import 'package:ecommerce_major_project/features/account/widgets/single_product.dart';
import 'package:ecommerce_major_project/features/account/services/account_services.dart';
import 'package:ecommerce_major_project/features/account/screens/all_orders_screen.dart';
import 'package:ecommerce_major_project/features/order_details/screens/order_details_screen.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

// status == 0 Pending
// status == 1 Completed
// status == 2 Received
// status == 3 Delivered
// status == 4 Product returned back

class _OrdersState extends State<Orders> {
  // List list = [
  //   "https://images.unsplash.com/photo-1681239063386-fc4a373c927b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60",
  //   "https://images.unsplash.com/photo-1682006289331-19e4e0327d6d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60",
  //   "https://images.unsplash.com/photo-1647891940243-77a6483a152e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60",
  //   "https://images.unsplash.com/photo-1681926946700-73c10c72ef15?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyN3x8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60"
  // ];

  List<Order>? orders;
  final AccountServices accountServices = AccountServices();
  bool showLoader = false;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    setState(() {
      showLoader = true;
    });
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {
      showLoader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: mq.width * 0.04),
              child: const Text("Your Orders",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            ),
            InkWell(
              onTap: orders == null || orders!.isEmpty
                  ? null
                  : () {
                      Navigator.pushNamed(context, AllOrdersScreen.routeName,
                          arguments: orders);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) =>
                      //         AllOrdersScreen(allOrders: orders)));
                    },
              child: Container(
                padding: EdgeInsets.only(right: mq.width * 0.04),
                child: Text(
                  "See all",
                  style: TextStyle(
                      // fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: GlobalVariables.selectedNavBarColor),
                ),
              ),
            ),
          ],
        ),
        showLoader
            ? const ColorLoader2()
            : orders == null
                ? Column(
                    children: [
                      Image.asset(
                        "assets/images/no-orderss.png",
                        height: mq.height * .25,
                      ),
                      SizedBox(height: mq.height * 0.02),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, BottomBar.routeName);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurpleAccent),
                          child: const Text(
                            "Keep Exploring",
                            style: TextStyle(color: Colors.white),
                          )),
                      // TextButton(
                      //     onPressed: () {
                      //       Navigator.pushNamed(context, HomeScreen.routeName);
                      //     },
                      //     child: Text(
                      //       "Explore ",
                      //       style: TextStyle(fontSize: 20),
                      //     ))
                    ],
                  )
                : Container(
                    height: mq.height * .2,
                    padding: EdgeInsets.only(
                        left: mq.width * .025, top: mq.width * .05, right: 0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: orders!.length,
                      itemBuilder: (context, index) {
                        // debugPrint(
                        //     " $index value of container width =======> ${mq.height * 0.025}");
                        print(
                            "\n -------------------> Fetched ORDERS are ${orders![index].id}");
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              OrderDetailsScreen.routeName,
                              arguments: orders![index],
                            );
                          },
                          child: SingleProduct(
                              image: orders![index].products[0].images[0]),
                        );
                      },
                    ),
                  )
      ],
    );
  }
}
