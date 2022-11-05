import 'package:flutter/material.dart';

import '../../../service/theme.dart';

Widget boxDescription(
    TextEditingController controller, double height, String hintText) {
  return Container(
    height: height * 0.25,
    width: double.infinity,
    decoration: BoxDecoration(
        color: Color(0xffF5F5F5), borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      child: TextFormField(
        style: TextStyle(fontSize: 16),
        cursorHeight: 17,
        cursorColor: mainColor.withOpacity(0.5),
        controller: controller,
        textInputAction: TextInputAction.newline,
        maxLines: null,
        minLines: 1,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 8),
            hintText: hintText,
            hintStyle: const TextStyle(overflow: TextOverflow.clip),
            border: InputBorder.none),
      ),
    ),
  );
}
