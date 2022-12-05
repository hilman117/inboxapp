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
        // height: Get.height * 0.1,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.green.shade100)),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: width * 0.08,
                height: height * 0.05,
                child: Image.asset("images/newlocation.png")),
            Container(
              width: Get.width * 0.70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "$newLocation",
                    style: TextStyle(
                        color: Colors.black87, fontSize: size * 0.012),
                    textAlign: TextAlign.end,
                  ),
                  Text(
                    time,
                    style: TextStyle(
                        fontSize: size * 0.01, color: Colors.grey, height: 1.5),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
