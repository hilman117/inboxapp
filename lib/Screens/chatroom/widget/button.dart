import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/theme.dart';

Widget button(String buttonName, VoidCallback callback) => SizedBox(
      height: Get.height * 0.04,
      width: Get.width * 0.3,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // <-- Radius
          ),
        ),
        onPressed: callback,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(buttonName),
        ),
      ),
    );
