import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/create/widget/bottom_sheet_image_picker.dart';

import '../../../service/theme.dart';

class ExecuteButton {
  Color themeColor = const Color(0xffF8CCA5);
  Color cardColor = const Color(0xff475D5B);
  Widget sendButton(BuildContext context, double widht, VoidCallback callback) {
    return SizedBox(
      width: widht * 0.3,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: mainColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          onPressed: callback,
          child: const Text("Send")),
    );
  }

  Widget imageButton(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.3,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              side: BorderSide(color: mainColor),
              foregroundColor: mainColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          onPressed: () {
            imagePicker(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.attach_file,
                size: 16,
              ),
              const Text("Attach"),
            ],
          )),
    );
  }
}
