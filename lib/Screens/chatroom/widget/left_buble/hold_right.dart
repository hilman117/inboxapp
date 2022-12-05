import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HoldBubble extends StatelessWidget {
  final String hold;
  final String time;
  const HoldBubble({required this.hold, required this.time});

  @override
  Widget build(BuildContext context) {
    double size = Get.width + Get.height;
    return Container(
        // height: Get.height * 0.1,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300)),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.pause,
              color: Colors.grey,
            ),
            Container(
              width: Get.width * 0.70,
              // color: Colors.blue.shade50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "$hold has held this request",
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
