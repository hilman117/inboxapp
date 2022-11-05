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
    height: Get.height * 0.045,
    width: Get.width * 0.8,
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: mainColor, width: 0.5))),
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
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Container(
            height: double.maxFinite,
            width: 0.5,
            color: mainColor,
          ),
        ),
        Expanded(
          child: SizedBox(
              height: Get.height * 0.045,
              child: TextFormField(
                textInputAction: action,
                keyboardType: textInputType,
                obscureText: isObsecure,
                controller: controller,
                style: TextStyle(fontSize: 18, color: mainColor),
                cursorColor: mainColor,
                cursorHeight: 18,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(color: mainColor),
                    contentPadding: const EdgeInsets.only(bottom: 15),
                    border: InputBorder.none),
              )),
        )
      ],
    ),
  );
}
