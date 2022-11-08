import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/theme.dart';

Widget button(String buttonName, VoidCallback callback) => SizedBox(
      height: Get.height * 0.04,
      width: Get.width * 0.25,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: secondary.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // <-- Radius
          ),
        ),
        onPressed: callback,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(buttonName),
        ),
      ),
    );
