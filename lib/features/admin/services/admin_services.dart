import 'dart:io';
import 'dart:convert';
import 'package:ecommerce_major_project/features/admin/models/sales.dart';
import 'package:ecommerce_major_project/models/order.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import '/providers/user_provider.dart';
import '/constants/global_variables.dart';
import '/constants/error_handling.dart';
import '/constants/utils.dart';
import '/models/product.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required String brandName,
    required num price,
    required int quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final cloudinary = CloudinaryPublic('dyqymg02u', 'ktdtolon');
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: "$category/$name"),
        );
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        brandName: brandName,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );

      //use jsonEncode before sending the body to POST request
      var bodyPostReq = jsonEncode(product.toJson());

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: bodyPostReq,
        // body: product.toJson(),
      );

      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context: context, text: 'Product Added Successfully!');
            Navigator.pop(context);
          },
        );
      }
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
  }

  // get all the products
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-products'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      var data = jsonDecode(res.body);
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            // for (int i = 0; i < jsonDecode(res.body).length; i++) {
            //   productList.add(
            //     Product.fromJson(
            //       jsonEncode(
            //         jsonDecode(res.body)[i],
            //       ),
            //     ),
            //   );
            // }

            for (Map<String, dynamic> item in data) {
              // print(item['name']);
              productList.add(Product.fromJson(item));
            }
          },
        );
      }
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
    return productList;
  }

  // get all the products
  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-orders'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      var data = jsonDecode(res.body);
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            // for (int i = 0; i < jsonDecode(res.body).length; i++) {
            //   productList.add(
            //     Product.fromJson(
            //       jsonEncode(
            //         jsonDecode(res.body)[i],
            //       ),
            //     ),
            //   );
            // }

            for (Map<String, dynamic> item in data) {
              // print(item['name']);
              orderList.add(Order.fromJson(jsonEncode(item)));
            }
          },
        );
      }
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
    return orderList;
  }

  // void sellProduct({
  //   required BuildContext context,
  //   required String name,
  //   required String description,
  //   required num price,
  //   required num quantity,
  //   required String category,
  //   required List<File> images,
  // }) async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //   try {
  //     //upload the images
  //     final cloudinary = CloudinaryPublic('dyqymg02u', 'ktdtolon');
  //     List<String> imageUrls = [];
  //     for (int i = 0; i < images.length; i++) {
  //       CloudinaryResponse res = await cloudinary
  //           .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
  //       imageUrls.add(res.secureUrl);
  //     }
  //     Product product = Product(
  //       name: name,
  //       description: description,
  //       quantity: quantity,
  //       category: category,
  //       images: imageUrls,
  //       price: price,
  //     );

  //     http.Response res = await http.post(
  //       Uri.parse("$uri/admin/add-product"),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'x-auth-token': userProvider.user.token,
  //       },
  //       body: product.toJson(),
  //     );

  //     //use context ensuring the mounted property across async functions
  //     if (context.mounted) {
  //       httpErrorHandle(
  //         response: res,
  //         context: context,
  //         onSuccess: () {
  //           showSnackBar(context: context, text: "Product added sucessfully!");
  //           Navigator.pop(context);
  //         },
  //       );
  //     }
  //   } catch (e) {
  //     showSnackBar(context: context, text: e.toString());
  //   }
  // }

  // //get all products
  // Future<List<Product>> fetchAllProducts(BuildContext context) async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //   List<Product> productList = [];

  //   try {
  //     http.Response res = await http
  //         .get(Uri.parse("$uri/admin/get-products"), headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'x-auth-token': userProvider.user.token,
  //     });

  //     // List listLength = jsonDecode(res.body);
  //     //jsonEncode => [object] to a JSON string.
  //     //jsonDecode => String to JSON object.
  //     if (context.mounted) {
  //       httpErrorHandle(
  //         response: res,
  //         context: context,
  //         onSuccess: () {
  //           for (int i = 0; i < jsonDecode(res.body).length; i++) {
  //             productList.add(
  //               Product.fromJson(
  //                 jsonEncode(
  //                   jsonDecode(res.body)[i],
  //                 ),
  //               ),
  //             );
  //           }
  //         },
  //       );
  //     }
  //     // print("Products length : ${jsonDecode(res.body).length}");
  //   } catch (e) {
  //     showSnackBar(
  //         context: context,
  //         text: "Following Error in fetching Products : ${e.toString()}");
  //   }
  //   return productList;
  // }

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    // checking the user auth token
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/admin/delete-product"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      //use context ensuring the mounted property across async functions
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          },
        );
      }
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
  }

  //
  //
  //
  //
  //
  //
  //
  void changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    // checking the user auth token
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/admin/change-order-status"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': order.id, 'status': status}),
      );

      //use context ensuring the mounted property across async functions
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: onSuccess,
        );
      }
    } catch (e) {
      showSnackBar(
          context: context,
          text: "AdminServices getEarnings function error ${e.toString()}");
    }
  }

//
//
//
//
//
//

  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    num totalEarning = 0;

    try {
      http.Response res =
          await http.get(Uri.parse("$uri/admin/analytics"), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            var response = jsonDecode(res.body);
            totalEarning = response['totalEarnings'];
            sales = [
              Sales('Mobiles', response['mobileEarnings']),
              Sales('Essentials', response['essentialsEarnings']),
              Sales('Appliances', response['appliancesEarnings']),
              Sales('Books', response['booksEarnings']),
              Sales('Fashion', response['fashionEarnings']),
            ];
          },
        );
      }
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
    return {
      "sales": sales,
      "totalEarnings": totalEarning,
    };
  }
}
