// import 'package:flutter/material.dart';
// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '/providers/user_provider.dart';
import '/common/widgets/bottom_bar.dart';
import '/constants/global_variables.dart';
import '/constants/error_handling.dart';
import '/constants/utils.dart';
import '/models/user.dart';

class AuthService {
  //signing up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      print("<============= signUpUser called ===============>");
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
        imageUrl: '',
        //https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnWaCAfSN08VMtSjYBj0QKSfHk4-fjJZCOxgHLPuBSAw&s
        cart: [],
      );

      //USING uri as it works for both Android and iOS
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              showSnackBar(
                  context: context, text: "Account created! You may login now");
            });
      }
    } catch (e) {
      print("Error occured in Signing up user : $e");
      showSnackBar(context: context, text: e.toString());
    }
  }

  //signing in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      //dont use context across asynchronous gaps
      if (context.mounted) {
        print("Response.body in signIn ${res.body}");
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            //using SharedPreferences to store the user token
            SharedPreferences prefs = await SharedPreferences.getInstance();

            //dont use context across asynchronous gaps
            //using provider change UI according to user
            if (context.mounted) {
              Provider.of<UserProvider>(context, listen: false)
                  .setUser(res.body);
            }

            //remember to use jsonDecode
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);

            //dont use context across asynchronous gaps
            if (context.mounted) {
              Navigator.pushNamedAndRemoveUntil(
                  context, BottomBar.routeName, (route) => false);
            }
          },
        );
      }
    } catch (e) {
      print("Error occured in Signing in user : $e");
      showSnackBar(context: context, text: e.toString());
    }
  }

  //getting user data
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      //first time user will have token as null
      //change it to empty string ''
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        //get user data
        http.Response userRes =
            //"$uri/" important to type a slash at the end
            await http.get(
                Uri.parse(
                  '$uri/',
                ),
                headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token,
            });
        // print(
        //     "==================> User Response Decoded :\n${jsonDecode(userRes.body)['_doc']} <==================");
        var userProvider = Provider.of<UserProvider>(context, listen: false);

        // userRes.body return this
        /*
                {
                  "$__": {
                    "activePaths": {
                      "paths": {
                        "password": "init",
                        "email": "init",
                        "name": "init",
                        "address": "init",
                        "type": "init",
                        "_id": "init",
                        "cart": "init",
                        "__v": "init"
                      },
                      "states": {
                        "require": {},
                        "default": {},
                        "init": {
                          "_id": true,
                          "name": true,
                          "email": true,
                          "password": true,
                          "address": true,
                          "type": true,
                          "cart": true,
                          "__v": true
                        }
                      }
                    },
                    "skipId": true
                  },
                  "$isNew": false,
                  "_doc": {
                    "_id": "6450dab71a92ba1d4664fa6f",
                    "name": "Rajput Aaryaveersinh",
                    "email": "akr@gmail.com",
                    "password": "$2a$08$bOhlBhitog4OvGyDgUdnne8/s8z3LCiTGGGHUgH.UlKlXOpaI8O0m",
                    "address": "",
                    "type": "user",
                    "cart": [],
                    "__v": 0
                  },
                  "name": "Rajput Aaryaveersinh",
                  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0NTBkYWI3MWE5MmJhMWQ0NjY0ZmE2ZiIsImlhdCI6MTY4MzAyMDQ3NX0.Au7GX5n9cnsH2qOkiBYUa5GB30XThWt0e_fKFSVeGrQ"
                }
          */
        // hence it is important to decode the body and set "_doc" as user
        // but token not working with this method
        // authorization not possible somehow
        // its about the auth middleware
        // userProvider.setUser(jsonEncode(jsonDecode(userRes.body)['_doc']));

        userProvider.setUser(userRes.body);

        // print(
        //     "==================> User Response :\n${userProvider.user.name} <==================");
      }
    } catch (e) {
      print("Error occured in signing up user : $e");
      showSnackBar(context: context, text: e.toString());
    }
  }
}

// else {}

//if not first time user then check the validity of the user
//making an API for verifying the token

// http.Response res = await http.post(
//   Uri.parse('$uri/api/signin'),
//   body: jsonEncode({
//     'email': email,
//     'password': password,
//   }),
//   headers: <String, String>{
//     'Content-Type': 'application/json; charset=UTF-8',
//   },
// );
// print(
//     "<============= after sign in http request ${res.body} ===============>");

// print(
//     "Response from signup  =====> ${res.body}, status code =====> ${res.statusCode}");

//dont use context across asynchronous gaps
// if (context.mounted) {
//   print(res.body);
//   httpErrorHandle(
//     response: res,
//     context: context,
//     onSuccess: () async {
//       //using SharedPreferences to store the user token
//       SharedPreferences prefs = await SharedPreferences.getInstance();

//       //dont use context across asynchronous gaps
//       //using provider change UI according to user
//       if (context.mounted) {
//         Provider.of<UserProvider>(context, listen: false)
//             .setUser(res.body);
//       }

//       //remember to use jsonDecode
//       await prefs.setString(
//           'x-auth-token', jsonDecode(res.body)['token']);

//       //dont use context across asynchronous gaps
//       if (context.mounted) {
//         Navigator.pushNamedAndRemoveUntil(
//             context, HomeScreen.routeName, (route) => false);
//       }
//     },
//   );
// }
