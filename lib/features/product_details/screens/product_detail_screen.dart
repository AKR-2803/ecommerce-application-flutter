// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ecommerce_major_project/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ecommerce_major_project/main.dart';
import 'package:ecommerce_major_project/models/product.dart';
import 'package:ecommerce_major_project/common/widgets/stars.dart';
import 'package:ecommerce_major_project/providers/user_provider.dart';
import 'package:ecommerce_major_project/constants/global_variables.dart';
import 'package:ecommerce_major_project/common/widgets/custom_button.dart';
import 'package:ecommerce_major_project/features/search/screens/search_screen.dart';
import 'package:ecommerce_major_project/features/product_details/services/product_detail_services.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-details';
  final Product product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailServices productDetailServices = ProductDetailServices();

  num myRating = 0.0;
  double avgRating = 0.0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0.0;

    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      //showing our own rating in the product details page
      //overall rating will be avgRating but
      //when we see a particular product we will be able to see
      //our given rating, i.e.  myRating
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }
    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  void navigateToSearchScreen(String query) {
    //make sure to pass the arguments here!

    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void addToCart() {
    print("Triggered add to cart <====");
    print("Product is  : ${widget.product.name}");
    productDetailServices.addToCart(context: context, product: widget.product);
    print("Execution finished add to cart <====");
  }

  @override
  Widget build(BuildContext context) {
    bool isProductAvailable = widget.product.quantity == 0;
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.width * .03)
              .copyWith(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  CarouselSlider(
                    items: widget.product.images.map((i) {
                      return Builder(
                        builder: (context) => Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Image.network(i,
                              fit: BoxFit.contain, height: mq.width * .48),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 2),
                      viewportFraction: 1,
                      height: mq.height * .36,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.share),
                  )
                ],
              ),
              Text(
                widget.product.name,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w200),
              ),
              SizedBox(height: mq.height * .01),
              Row(
                // mainAxisAlignment: MainAxisAlignment,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 1),
                      // color: Color.fromARGB(255, 147, 147, 147),
                    ),
                    child: Text(
                      "₹ ${widget.product.price}  ",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 22,
                          // color: Colors.,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(width: mq.width * .05),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("$avgRating ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Icon(Icons.star, color: Colors.yellow.shade600),
                      // SizedBox(width: mq.width * .01),
                      Text(
                        "(1.8K Reviews)",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  )
                  // Text(widget.product.id!),
                ],
              ),
              Divider(
                endIndent: mq.width * .01,
                indent: mq.width * .01,
                thickness: 2,
                color: Colors.grey[300],
              ),
              Text("About the Product",
                  style: TextStyle(fontWeight: FontWeight.w700)),
              Container(
                padding: EdgeInsets.all(mq.height * .01),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400, width: 0.7),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 2)
                    ]),
                child: Text(
                  widget.product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: mq.height * .01),
              Divider(
                endIndent: mq.width * .01,
                indent: mq.width * .01,
                thickness: 2,
                color: Colors.grey[300],
              ),
              // SizedBox(height: mq.height * .01),
              isProductAvailable
                  ? const Text("Out of Stock",
                      style: TextStyle(
                          color: Colors.redAccent, fontWeight: FontWeight.w600))
                  : const Text("In Stock",
                      style: TextStyle(color: Colors.teal)),
              // Container(height: 5, color: Colors.grey[200]),
              SizedBox(height: mq.height * .01),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, mq.height * .08),
                  backgroundColor: Colors.yellow.shade500,
                ),
                child: const Text("Buy Now",
                    style: TextStyle(color: Colors.black)),
              ),
              SizedBox(height: mq.width * .025),
              CustomButton(
                text: "Add to Cart",
                onTap: isProductAvailable
                    ? () {
                        showSnackBar(
                            context: context, text: "Product out of stock");
                      }
                    : () {
                        showSnackBar(context: context, text: "Added to cart");
                        addToCart();
                      },
                color: Colors.yellow.shade800,
              ),
              // Container(height: 5, color: Colors.grey[200]),
              SizedBox(height: mq.width * .03),
              const Text("Rate the Product",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              RatingBar.builder(
                //rating given by user
                initialRating: double.parse(myRating.toString()),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemPadding: EdgeInsets.symmetric(horizontal: mq.width * .0125),
                itemCount: 5,
                itemBuilder: (context, _) {
                  return const Icon(
                    Icons.star,
                    color: GlobalVariables.secondaryColor,
                  );
                },
                //
                //changes here
                onRatingUpdate: (rating) {
                  productDetailServices.rateProduct(
                    context: context,
                    product: widget.product,
                    rating: rating,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
