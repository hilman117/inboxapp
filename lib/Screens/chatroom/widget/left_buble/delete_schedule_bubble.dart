import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/dasboard/widget/card.dart';

class DeleteScheduleBubble extends StatelessWidget {
  final String deleteSchedule;
  final String time;
  const DeleteScheduleBubble(
      {required this.deleteSchedule, required this.time});

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
            border: Border.all(color: Colors.grey.shade300)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "$deleteSchedule has removed due date",
                  style:
                      TextStyle(color: Colors.black87, fontSize: size * 0.012),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  Icons.free_cancellation,
                  color: Colors.grey,
                ),
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
