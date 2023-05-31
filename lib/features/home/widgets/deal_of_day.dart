import 'package:flutter/material.dart';

import 'package:ecommerce_major_project/main.dart';
import 'package:ecommerce_major_project/models/product.dart';
import 'package:ecommerce_major_project/common/widgets/color_loader_2.dart';
import 'package:ecommerce_major_project/features/home/services/home_services.dart';
import 'package:ecommerce_major_project/features/product_details/screens/product_detail_screen.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  final HomeServices homeServices = HomeServices();
  Product? product;

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(context, ProductDetailScreen.routeName,
        arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const ColorLoader2()
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: navigateToDetailScreen,
                child: Column(
                  children: [
                    Container(
                      // color: Colors.cyanAccent,
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: mq.width * .03),
                      child: const Text("Deal of the Day",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800)),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          // elevation: 3,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.all(mq.height * .033)
                              .copyWith(bottom: 0),
                          child: Image.network(
                            // "https://github.com/AKR-2803/ShoesAppUIFlutter/blob/main/assets/images/shoes_display.png?raw=true",
                            product!.images[0],
                            height: mq.height * .25,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Image.asset("assets/images/dealOfTheDaypng.png",
                            height: mq.height * 0.075),
                      ],
                    ),
                    // Container(
                    //   alignment: Alignment.topLeft,
                    //   padding:
                    //       const EdgeInsets.only(left: 15, right: 40, top: 5),
                    //   child: Text("₹${product!.price.toStringAsFixed(2)}",
                    //       style: TextStyle(
                    //           fontWeight: FontWeight.bold, fontSize: 18)),
                    // ),
                    // Container(
                    //   alignment: Alignment.topLeft,
                    //   padding:
                    //       const EdgeInsets.only(left: 15, right: 40, top: 5),
                    //   child: const Text(
                    //     "Product #1",
                    //     maxLines: 2,
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    // ),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: product!.images
                    //         .map(
                    //           (e) => Image.network(
                    //             e,
                    //             height: 100,
                    //             width: 100,
                    //             fit: BoxFit.fitWidth,
                    //           ),
                    //         )
                    //         .toList(),
                    //   ),
                    // ),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(vertical: 15)
                    //       .copyWith(left: 15),
                    //   alignment: Alignment.topLeft,
                    //   child: Text(
                    //     "See all deals",
                    //     style: TextStyle(color: Colors.cyan.shade800),
                    //   ),
                    // )
                  ],
                ),
              );
  }
}
