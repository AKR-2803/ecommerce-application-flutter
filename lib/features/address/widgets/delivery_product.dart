import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommerce_major_project/main.dart';
import 'package:ecommerce_major_project/models/product.dart';
import 'package:ecommerce_major_project/providers/user_provider.dart';
import 'package:ecommerce_major_project/features/cart/services/cart_services.dart';
import 'package:ecommerce_major_project/features/product_details/services/product_detail_services.dart';

class DeliveryProduct extends StatefulWidget {
  final int index;
  const DeliveryProduct({required this.index, super.key});

  @override
  State<DeliveryProduct> createState() => _DeliveryProductState();
}

class _DeliveryProductState extends State<DeliveryProduct> {
  final ProductDetailServices productDetailServices = ProductDetailServices();
  final CartServices cartServices = CartServices();

  void increaseQuantity(Product product) {
    productDetailServices.addToCart(context: context, product: product);
  }

  void decreaseQuantity(Product product) {
    cartServices.removeFromCart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    // fetching the particular product
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromJson(productCart['product']);
    final quantity = productCart['quantity'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // image
        Image.network(
          product.images[0],
          fit: BoxFit.contain,
          height: mq.width * .25,
          width: mq.width * .25,
        ),
        // description
        Column(
          children: [
            Container(
              width: mq.width * .57,
              padding:
                  EdgeInsets.only(left: mq.width * .025, top: mq.width * .0125),
              child: Text(
                product.name,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 15),
                maxLines: 1,
              ),
            ),
            Container(
              width: mq.width * .57,
              padding: EdgeInsets.only(left: mq.width * .025),
              child: Text(
                "₹ ${product.price.toStringAsFixed(2)}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                maxLines: 2,
              ),
            ),
            Container(
              width: mq.width * .57,
              padding: EdgeInsets.only(left: mq.width * .025),
              child: Text(
                product.price < 500
                    ? "Shipping charges might apply"
                    : "Eligible for free shipping",
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
