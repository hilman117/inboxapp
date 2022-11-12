import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingMenu extends StatelessWidget {
  final String menuName;
  final Widget widget;
  final VoidCallback callback;
  const SettingMenu(
      {super.key,
      required this.menuName,
      required this.widget,
      required this.callback});

  @override
  Widget build(BuildContext context) {
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
}

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
