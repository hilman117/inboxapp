import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:post/common_widget/card.dart';

class Resume extends StatelessWidget {
  final String resume;
  final String time;
  const Resume({required this.resume, required this.time});

  @override
  Widget build(BuildContext context) {
    double size = Get.width + Get.height;
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: width * 0.2),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)),
              border: Border.all(color: Colors.green.shade100)),
          width: width * 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: width * 0.07,
                      height: height * 0.04,
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.green,
                      )),
                  Container(
                    width: width * 0.63,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "$resume resume this request",
                      style: TextStyle(
                          color: Colors.black87, fontSize: size * 0.012),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              Text(
                DateFormat('EE d, HH:mm').format(DateTime.parse(time)),
                style: TextStyle(
                    fontSize: size * 0.01, color: Colors.grey, height: 1.5),
              ),
            ],
          )),
    );
  }
}
