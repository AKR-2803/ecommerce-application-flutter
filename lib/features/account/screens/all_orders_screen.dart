// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_major_project/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:ecommerce_major_project/common/widgets/custom_appbar.dart';
import 'package:ecommerce_major_project/constants/global_variables.dart';
import 'package:ecommerce_major_project/features/order_details/screens/order_details_screen.dart';
import 'package:ecommerce_major_project/features/product_details/screens/product_detail_screen.dart';
import 'package:ecommerce_major_project/features/search_delegate/my_search_screen.dart';
import 'package:ecommerce_major_project/main.dart';
import 'package:ecommerce_major_project/models/order.dart';

import '../../search/widgets/searched_product.dart';

class AllOrdersScreen extends StatefulWidget {
  static const String routeName = '/all-orders-screen';
  List<Order>? allOrders;
  AllOrdersScreen({
    Key? key,
    this.allOrders,
  }) : super(key: key);

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

// Fetching all orders logic
/*
          for (int i = 0; i < widget.allOrders!.length; i++)
            for (int j = 0; j < widget.allOrders![i].products.length; j++)
              Text(
                  "order id : ${widget.allOrders![i].orderedAt} ${widget.allOrders![i].products[j].name}\n",
                  style: TextStyle(fontSize: 15)),


*/

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalVariables.getAppBar(
          title: "All Orders",
          context: context,
          onClickSearchNavigateTo: MySearchScreen()),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const AddressBox(),
          // SizedBox(height: mq.width * .025),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.allOrders!.length,
              itemBuilder: (context, index) {
                // print(
                //     "\n -------------------> ALL ORDERS  : ${allOrders![index].products[index]}");
                return Card(
                  color: Color.fromARGB(255, 245, 239, 255),
                  margin: EdgeInsets.symmetric(horizontal: mq.width * .02),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(width: .2)),
                  child: Column(
                    children: [
                      Container(
                        // color: Colors.deepOrange,
                        margin: EdgeInsets.only(
                            top: mq.height * .01, right: mq.height * .01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.deepPurple.shade800,
                                  borderRadius: BorderRadius.circular(10)),

                              // elevation: 2,
                              // alignment: Alignment.topRight,
                              child: Text(
                                "Order ID : ${widget.allOrders![index].id}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                            SizedBox(width: mq.height * .01),
                            InkWell(
                                onTap: () async {
                                  await Clipboard.setData(ClipboardData(
                                          text: widget.allOrders![index].id))
                                      .then((_) => showSnackBar(
                                          context: context, text: "Copied!"));
                                },
                                child: Icon(Icons.copy, size: 17))
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            OrderDetailsScreen.routeName,
                            arguments: widget.allOrders![index],
                          );
                          // Navigator.pushNamed(
                          //     context, ProductDetailScreen.routeName,
                          //     arguments: allOrders![index]);
                          Navigator.pushNamed(
                              context, OrderDetailsScreen.routeName);
                        },
                        child: Column(
                          children: [
                            for (int j = 0;
                                j < widget.allOrders![index].products.length;
                                j++)
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: mq.width * .025),
                                child: Row(
                                  children: [
                                    // image
                                    Image.network(
                                      widget.allOrders![index].products[j]
                                          .images[0],
                                      // allOrders![index].products[index].images[0],
                                      fit: BoxFit.contain,
                                      height: mq.width * .25,
                                      width: mq.width * .25,
                                    ),
                                    // description
                                    Column(
                                      children: [
                                        Container(
                                          width: mq.width * .57,
                                          padding: EdgeInsets.only(
                                              left: mq.width * .025,
                                              top: mq.width * .0125),
                                          child: Text(
                                            widget.allOrders![index].products[j]
                                                .name,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style:
                                                const TextStyle(fontSize: 16),
                                            maxLines: 1,
                                          ),
                                        ),
                                        // Container(
                                        //   width: mq.width * .57,
                                        //   padding: EdgeInsets.only(
                                        //       left: mq.width * .025, top: mq.width * .0125),
                                        //   //here is the static rating
                                        //   child: Stars(rating: avgRating),
                                        // ),
                                        Container(
                                          width: mq.width * .57,
                                          padding: EdgeInsets.only(
                                              left: mq.width * .025,
                                              top: mq.width * .0125),
                                          child: Text(
                                              "Ordered At  : ${DateFormat('yMMMd').format(DateTime.fromMillisecondsSinceEpoch(widget.allOrders![index].orderedAt))}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14)),
                                        ),
                                        // Container(
                                        //   width: mq.width * .57,
                                        //   padding: EdgeInsets.only(left: mq.width * .025),
                                        //   child: Text("Eligible for free shipping"),
                                        // ),
                                        // Container(
                                        //   width: mq.width * .57,
                                        //   padding: EdgeInsets.only(
                                        //       left: mq.width * .025, top: mq.width * .0125),
                                        //   child: product.quantity == 0
                                        //       ? const Text(
                                        //           "Out of Stock",
                                        //           style: TextStyle(color: Colors.redAccent),
                                        //           maxLines: 2,
                                        //         )
                                        //       : const Text(
                                        //           "In Stock",
                                        //           style: TextStyle(color: Colors.teal),
                                        //           maxLines: 2,
                                        //         ),
                                        // ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: mq.height * .01,
                                    )
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Divider(color: Colors.grey, thickness: mq.height * .001)
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
