import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  bool? isObscureText;
  TextInputType inputType;
  CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.isObscureText = false,
    this.inputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      controller: controller,
      maxLines: maxLines,
      obscureText: isObscureText!,
      keyboardType: inputType,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 236, 236, 236),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 0.8, color: Colors.grey.shade800),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 0.25),
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return '$hintText required';
        }
        return null;
      },
    );
  }
}
