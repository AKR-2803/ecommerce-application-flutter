import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ecommerce_major_project/models/order.dart';
import 'package:ecommerce_major_project/constants/utils.dart';
import 'package:ecommerce_major_project/providers/user_provider.dart';
import 'package:ecommerce_major_project/constants/error_handling.dart';
import 'package:ecommerce_major_project/constants/global_variables.dart';
import 'package:ecommerce_major_project/features/auth/screens/auth_screen.dart';

class AccountServices {
  getAllOrders({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    http.Response res = await http.get(
      Uri.parse("$uri/api/order"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      },
    );

    var data = jsonDecode(res.body);

    if (context.mounted) {
      httpErrorHandle(response: res, context: context, onSuccess: () {});
    }
  }

//
//
//
//
//
//
//
//
//
//
//
//
//
  Future<List<Order>?> fetchMyOrders({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order>? orderList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/orders/me'), headers: {
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
            //   orderList.add(Order.fromJson(item));
            // }
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              orderList.add(
                Order.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          },
        );
        // print("response  : \n\n${orderList[0]}");
        // print("price type : \n\n${orderList[0].price.runtimeType}");
        // print("quantity type : \n\n${orderList[0].quantity.runtimeType}");
      }
    } catch (e) {
      showSnackBar(
          context: context,
          text: "Following Error in fetching Products [home]: $e");
    }
    return orderList;
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('x-auth-token', '');
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, AuthScreen.routeName, (route) => false);
      }
    } catch (e) {
      showSnackBar(context: context, text: "Error in logging out : $e");
    }
  }
}
