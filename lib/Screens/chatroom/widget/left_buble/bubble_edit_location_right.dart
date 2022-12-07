import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../dasboard/widget/card.dart';

class EditLoactionBubble extends StatelessWidget {
  final String newLocation;
  final String time;
  const EditLoactionBubble({required this.newLocation, required this.time});

  @override
  Widget build(BuildContext context) {
    double size = Get.width + Get.height;
    return Container(
        margin: EdgeInsets.only(right: width * 0.2),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)),
            border: Border.all(color: Colors.green.shade100)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                width: Get.width * 0.70,
                child: Text(
                  "$newLocation",
                  style:
                      TextStyle(color: Colors.black87, fontSize: size * 0.012),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    width: width * 0.08,
                    height: height * 0.05,
                    child: Image.asset("images/newlocation.png")),
                Text(
                  time,
                  style: TextStyle(
                      fontSize: size * 0.01, color: Colors.grey, height: 1.5),
                ),
              ],
            ),
          ],
        ));
  }
}
