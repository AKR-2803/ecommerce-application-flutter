import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(color: Colors.black));
  }
}

//loader dialog
// import 'package:flutter/material.dart';

// showLoader(BuildContext context) {
//   return showDialog(
//       context: context,
//       //user cannot interrupt the loader
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return const Center(
//           child: CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//           ),
//         );
//       });
// }
