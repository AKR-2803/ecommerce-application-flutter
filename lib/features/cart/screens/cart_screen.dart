import 'package:ecommerce_major_project/common/widgets/bottom_bar.dart';
import 'package:ecommerce_major_project/constants/utils.dart';
import 'package:ecommerce_major_project/features/home/screens/home_screen.dart';
import 'package:ecommerce_major_project/features/search_delegate/my_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:ecommerce_major_project/main.dart';
import 'package:ecommerce_major_project/providers/user_provider.dart';
import 'package:ecommerce_major_project/constants/global_variables.dart';
import 'package:ecommerce_major_project/common/widgets/custom_button.dart';
import 'package:ecommerce_major_project/features/home/widgets/address_box.dart';
import 'package:ecommerce_major_project/features/cart/widgets/cart_product.dart';
import 'package:ecommerce_major_project/features/cart/widgets/cart_subtotal.dart';
import 'package:ecommerce_major_project/features/search/screens/search_screen.dart';
import 'package:ecommerce_major_project/features/address/screens/address_screen.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = '/cart';
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query) {
    //make sure to pass the arguments here!
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigateToAddress(num sum) {
    //make sure to pass the arguments here!
    Navigator.pushNamed(context, AddressScreen.routeName,
        arguments: sum.toString());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    num sum = 0;

    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as num)
        .toList();

    return Scaffold(
      appBar: GlobalVariables.getAppBar(
          context: context,
          wantBackNavigation: false,
          title: "Your Cart",
          onClickSearchNavigateTo: MySearchScreen()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressBox(),
            const CartSubtotal(),
            Padding(
              padding: EdgeInsets.all(mq.width * .025),
              child: CustomButton(
                  text:
                      "Proceed to buy (${user.cart.length} ${user.cart.length == 1 ? 'item' : 'items'})",
                  onTap: () =>
                      user.cart.isEmpty ? () {} : navigateToAddress(sum),
                  color: user.cart.isEmpty
                      ? Colors.yellow[200]
                      : Colors.yellow[600]),
            ),
            SizedBox(height: mq.height * 0.02),
            Container(color: Colors.black12.withOpacity(0.08), height: 1),
            SizedBox(height: mq.height * 0.02),
            SizedBox(
              height: mq.height * 0.55,
              child: user.cart.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset("assets/images/no-orderss.png",
                            height: mq.height * .25),
                        const Text(
                          "Oops, no item in cart",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(height: mq.height * .01),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, BottomBar.routeName);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurpleAccent),
                          child: const Text("Keep Exploring",
                              style: TextStyle(color: Colors.white)),
                        )
                      ],
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      // shrinkWrap: true,
                      itemCount: user.cart.length,
                      itemBuilder: (context, index) {
                        // return CartProdcut
                        return CartProduct(index: index);
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
