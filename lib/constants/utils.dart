import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

void showSnackBar({
  required BuildContext context,
  required String text,
  VoidCallback? onTapFunction,
  String? actionLabel,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    onTapFunction != null && actionLabel != null
        ? SnackBar(
            content: Text(text),
            action: SnackBarAction(
              label: actionLabel,
              textColor: Colors.white,
              onPressed: onTapFunction,
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: const Color(0xFF7700C6),
          )
        : SnackBar(
            content: Text(text),
            behavior: SnackBarBehavior.floating,
            backgroundColor: const Color(0xFF7700C6),
          ),
  );
}

void showErrorSnackBar({
  required BuildContext context,
  required String text,
  VoidCallback? onTapFunction,
  String? actionLabel,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    onTapFunction != null && actionLabel != null
        ? SnackBar(
            content: Text(text),
            action: SnackBarAction(
              label: actionLabel,
              textColor: Colors.white,
              onPressed: onTapFunction,
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Color.fromARGB(255, 252, 30, 100),
          )
        : SnackBar(
            content: Text(text),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Color.fromARGB(255, 252, 30, 100),
          ),
  );
}

// void showSnackBar(BuildContext context, String msg, Duration passDuration) {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//     content: Text(msg),
//     duration: passDuration,
//     behavior: SnackBarBehavior.floating,
//     backgroundColor: const Color(0xFF7700C6),
//     //Text Copied snackbar(in message_card bottomsheet) color : const Color(0xFFA841FC)
//   ));
// }

Future<List<File>> pickImages() async {
  List<File> images = [];

  try {
    FilePickerResult? files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint("Error in picking image : ${e.toString()}");
  }

  return images;
}
