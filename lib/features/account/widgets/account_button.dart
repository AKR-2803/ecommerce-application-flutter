import 'package:flutter/material.dart';
import '/main.dart';

//account page buttons
class AccountButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const AccountButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: mq.height * .06,
        margin: EdgeInsets.symmetric(horizontal: mq.width * .025),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(mq.height * .06),
        ),
        child: OutlinedButton(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
              backgroundColor: Colors.black12.withOpacity(.03),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(mq.height * .06),
              )),
          child: Text(
            text,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
