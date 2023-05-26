import 'dart:convert';

import 'package:ecommerce_major_project/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:ecommerce_major_project/models/product.dart';
import 'package:ecommerce_major_project/constants/utils.dart';
import 'package:ecommerce_major_project/providers/user_provider.dart';
import 'package:ecommerce_major_project/constants/error_handling.dart';
import 'package:ecommerce_major_project/constants/global_variables.dart';

class HomeServices {
  // fetch products category wise

  Future<List<Product>> fetchCategoryProducts(
      {required BuildContext context, required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    String tokenValue = userProvider.user.token;
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products?category=$category'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': tokenValue,
      });

      var data = jsonDecode(res.body);
      if (context.mounted) {
        // print(
        //     "quantity : \n\n${jsonEncode(jsonDecode(res.body)[0]).runtimeType}");
        // print("response : \n\n${jsonDecode(res.body)[1]}");
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (Map<String, dynamic> item in data) {
              // print(item['name']);
              productList.add(Product.fromJson(item));
            }
            //    for (int i = 0; i < jsonDecode(res.body).length; i++) {
            //   productList.add(
            //     Product.fromJson(
            //       jsonEncode(
            //         jsonDecode(res.body)[i],
            //       ),
            //     ),
            //   );
            // }
          },
        );
        // print("response  : \n\n${productList[0]}");
        // print("price type : \n\n${productList[0].price.runtimeType}");
        // print("quantity type : \n\n${productList[0].quantity.runtimeType}");
      }
    } catch (e) {
      showSnackBar(
          context: context,
          text: "Following Error in fetching Products [home]: $e");
    }
    return productList;
  }

//
//
//
//
//
//

  // fetch deal of the day
  Future<Product> fetchDealOfDay({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product product = Product(
      name: '',
      description: '',
      brandName: '',
      images: [],
      quantity: 0,
      price: 0.0,
      category: '',
    );

    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/deal-of-day'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      if (context.mounted) {
        // print(
        //     "quantity : \n\n${jsonEncode(jsonDecode(res.body)[0]).runtimeType}");
        // print("response : \n\n${jsonDecode(res.body)[1]}");
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            // for (Map<String, dynamic> item in data) {
            //   // print(item['name']);
            //   // productList.add(Product.fromJson(item));
            //   product = Product.fromJson(item);
            // }

            // var data = jsonDecode(res.body);
            product = Product.fromJson(jsonDecode(res.body));
          },
        );
      }
    } catch (e) {
      showSnackBar(
          context: context,
          text: "Following Error in fetching deal-of-the-day : $e");
    }
    return product;
  }

//
//
//
//
//
//

  Future<List<String>> fetchAllProductsNames(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<String> productNames = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/get-all-products-names'), headers: {
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

            for (String item in data) {
              // print(item['name']);
              productNames.add(item);
            }
          },
        );
      }
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
    return productNames;
  }

//
//
//
//
//
//

  void addToHistory({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/api/search-history"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'searchQuery': searchQuery}),
      );

      //use context ensuring the mounted property across async functions
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            // type casting List<dynamic>? to List<String>?
            // by mapping each item from List<dynamic>? to String
            List<String>? searchHistoryFromDB =
                (jsonDecode(res.body)['searchHistory'] as List)
                    .map((item) => item as String)
                    .toList();
            User user =
                userProvider.user.copyWith(searchHistory: searchHistoryFromDB);
            userProvider.setUserFromModel(user);
            print("\nUser searchHistory now is ${user.searchHistory}");
          },
        );
      }
    } catch (e) {
      showSnackBar(
          context: context, text: "Error in addToHistory ${e.toString()}");
    }
  }

//
//
//
//
//
//

  void deleteSearchHistoryItem({
    required BuildContext context,
    required String deleteQuery,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/api/delete-search-history-item"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'deleteQuery': deleteQuery}),
      );

      //use context ensuring the mounted property across async functions
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {},
        );
      }
    } catch (e) {
      showSnackBar(
          context: context,
          text: "Error in delete search history item ${e.toString()}");
    }
  }

//
//
//
//
//
//

  Future<List<String>> fetchSearchHistory(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<String> searchHistoryList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/get-search-history'), headers: {
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

            for (String item in data) {
              // print(item['name']);
              searchHistoryList.add(item);
            }
          },
        );
      }
    } catch (e) {
      showSnackBar(context: context, text: e.toString());
    }
    return searchHistoryList;
  }

//
//
//
//

  void addToWishList({
    required BuildContext context,
    required Product product,
  }) async {
    print("========> Inside the add to /api/add-to-wishList function");
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-wishList'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': product.id}),
      );
      print("\nwishList   :  ${userProvider.user.wishList} ");

      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            // print("\nInside on success method..");
            User user = userProvider.user
                .copyWith(wishList: jsonDecode(res.body)['wishList']);
            userProvider.setUserFromModel(user);
            print("\nUser wishList now is ${user.wishList}");
          },
        );
      }
    } catch (e) {
      print("\n========>Inside the catch block");
      showSnackBar(context: context, text: e.toString());
    }
  }
}

//
//
//
//

// Future<List<Product>?> fetchWishList(BuildContext context) async {
//   final userProvider = Provider.of<UserProvider>(context, listen: false);
//   List<Product>? wishList = [];
//   try {
//     http.Response res =
//         await http.get(Uri.parse('$uri/api/get-wishList'), headers: {
//       'Content-Type': 'application/json; charset=UTF-8',
//       'x-auth-token': userProvider.user.token,
//     });

//     var data = jsonDecode(res.body);
//     if (context.mounted) {
//       httpErrorHandle(
//         response: res,
//         context: context,
//         onSuccess: () {
//           for (Product item in data) {
//             // print(item['name']);
//             wishList.add(item);
//           }
//         },
//       );
//     }
//   } catch (e) {
//     showSnackBar(
//         context: context, text: "Error in fetchWishList : ${e.toString()}");
//   }
//   return wishList;
// }

//
//
//
//

// class HomeServices {
//   Future<List<Product>> fetchCategoryProducts(
//       {required BuildContext context, required String category}) async {
//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     List<Product> productList = [];

//     try {
//       http.Response res = await http.get(
//           Uri.parse("$uri/api/products?category=$category"),
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//             'x-auth-token': userProvider.user.token,
//           });

//       // print("res.body : ${res.body}");
//       // List listLength = jsonDecode(res.body);
//       //jsonEncode => [object] to a JSON string.
//       //jsonDecode => String to JSON object.
//       if (context.mounted) {
//         httpErrorHandle(
//           response: res,
//           context: context,
//           onSuccess: () {
//             for (int i = 0; i < jsonDecode(res.body).length; i++) {
//               productList.add(
//                 Product.fromJson(
//                   jsonEncode(
//                     jsonDecode(res.body)[i],
//                   ),
//                 ),
//               );
//               // print("\n\n\nreq.body JsonDecode${jsonDecode(res.body)}");
//             }
//           },
//         );
//       }

//       // print("Products length : ${jsonDecode(res.body).length.runtimeType}");
//     } catch (e) {
//       showSnackBar(
//           context: context,
//           text: "Following Error in fetching Products : ${e.toString()}");
//     }
//     return product;
//   }
// }
