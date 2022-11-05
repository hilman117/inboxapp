import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget tileDept(String departement, VoidCallback callback, String image) {
  double widht = Get.width;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: InkWell(
      onTap: callback,
      child: Container(
        height: 35,
        child: Row(
          children: [
            Image.asset("images/$image.png", width: widht * 0.06),
            SizedBox(
              width: widht * 0.04,
            ),
            Text(
              departement,
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    ),
  );
}
