import 'package:ecommerce_major_project/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/user_provider.dart';
import '/main.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .05),
      padding: EdgeInsets.only(left: mq.width * .025),
      height: mq.height * .055,
      decoration: BoxDecoration(
          border: Border.all(width: 0.7, color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(15)
          // gradient: LinearGradient(
          //   colors: [
          //     Color.fromARGB(255, 114, 226, 221),
          //     Color.fromARGB(255, 162, 236, 233),
          //   ],
          //   stops: [0.5, 1.0],
          // ),
          ),
      child: Row(
        children: [
          Icon(Icons.location_on_outlined,
              color: GlobalVariables.secondaryGreyTextColor),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: mq.width * .0125),
              child: Text(
                "Delivery to ${user.name} - ${user.address}",
                style: TextStyle(
                    color: GlobalVariables.secondaryGreyTextColor,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 12),
              ),
            ),
          ),
          // Padding(
          //     padding: EdgeInsets.only(
          //         left: mq.width * .0125, right: mq.width * .0125),
          //     child: const Icon(Icons.arrow_drop_down_outlined, size: 22))
        ],
      ),
    );
  }
}
