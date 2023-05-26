import 'dart:convert';
import '/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    //Successful responses (200 – 299)
    //200 OK
    case 200:
      onSuccess();
      break;

    //decoding response.body to String
    //Client error responses (400 – 499)
    //400 Bad Request
    case 400:
      showSnackBar(context: context, text: jsonDecode(response.body)['msg']);
      break;

    //Server error responses (500 – 599)
    //500 Internal Serveer Error
    case 500:
      showSnackBar(context: context, text: jsonDecode(response.body)['error']);
      break;

    default:
      showSnackBar(context: context, text: response.body);
      break;
  }
}







// import 'dart:convert';
// import 'package:ecommerce_major_project/constants/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void httpErrorHandle({
//   required http.Response response,
//   required BuildContext context,
//   required VoidCallback onSuccess,
// }) {
//   switch (response.statusCode) {
//     case 200:
//       onSuccess();
//       break;
//     case 400:
//       //decoding response.body to String
//       showSnackBar(context: context, text: jsonDecode(response.body)['msg']);
//       break;
//     case 500:
//       showSnackBar(context: context, text: jsonDecode(response.body)['error']);
//       break;
//     default:
//       showSnackBar(context: context, text: response.body);
//       break;
//   }
// }


