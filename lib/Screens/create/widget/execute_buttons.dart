import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/create/widget/bottom_sheet_image_picker.dart';

import '../../../service/theme.dart';

class ExecuteButton {
  Color themeColor = const Color(0xffF8CCA5);
  Color cardColor = const Color(0xff475D5B);
  Widget sendButton(BuildContext context, double widht, VoidCallback callback) {
    return SizedBox(
      height: Get.height * 0.055,
      width: Get.width,
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
      width: Get.width * 0.40,
      height: Get.height * 0.048,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: mainColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              )),
          onPressed: () {
            imagePicker(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Photo",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
              Image.asset(
                'images/camera.png',
                width: 20,
              )
            ],
          )),
    );
  }
}
