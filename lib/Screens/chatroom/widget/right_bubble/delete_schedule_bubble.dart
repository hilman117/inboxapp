import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:post/common_widget/card.dart';

class DeleteScheduleBubble extends StatelessWidget {
  final String deleteSchedule;
  final String time;
  const DeleteScheduleBubble(
      {required this.deleteSchedule, required this.time});

  @override
  Widget build(BuildContext context) {
    double size = Get.width + Get.height;
    return Container(
        margin: EdgeInsets.only(left: width * 0.2),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)),
            border: Border.all(color: Colors.red.shade100)),
        width: width * 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width * 0.63,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "$deleteSchedule has removed the schedule",
                    style: TextStyle(
                        color: Colors.black87, fontSize: size * 0.012),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                    width: width * 0.07,
                    height: height * 0.04,
                    child: Icon(
                      Icons.free_cancellation_outlined,
                      color: Colors.red,
                    )),
              ],
            ),
            Text(
              DateFormat('EE d, HH:mm').format(DateTime.parse(time)),
              style: TextStyle(
                  fontSize: size * 0.01, color: Colors.grey, height: 1.5),
            ),
          ],
        ));
  }
}
