import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/theme.dart';

Widget signInForm(
    IconData icon,
    TextEditingController controller,
    String hintText,
    bool isObsecure,
    VoidCallback callback,
    TextInputType textInputType,
    TextInputAction action,
    dynamic context,
    Color formColor) {
  return Container(
    height: Get.height * 0.06,
    width: Get.width * 0.8,
    decoration: BoxDecoration(
        color: mainColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: InkWell(
                radius: 15,
                customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onTap: callback,
                child: Icon(icon, color: mainColor, size: 22))),
        Expanded(
          child: SizedBox(
              height: Get.height * 0.045,
              child: TextFormField(
                textInputAction: action,
                keyboardType: textInputType,
                obscureText: isObsecure,
                controller: controller,
                style: textStyle,
                cursorColor: mainColor,
                cursorHeight: 16,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: textStyle,
                    contentPadding: const EdgeInsets.only(bottom: 15),
                    border: InputBorder.none),
              )),
        )
      ],
    ),
  );
}
