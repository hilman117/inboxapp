import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget settingMenu(String menuName, Widget widget, VoidCallback callback) {
  return Column(
    children: [
      InkWell(
        onTap: callback,
        child: Container(
          height: Get.height * 0.065,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  menuName,
                  style: const TextStyle(color: Colors.grey),
                  overflow: TextOverflow.clip,
                ),
              ),
              widget
            ],
          ),
        ),
      ),
      Divider(),
    ],
  );
}
