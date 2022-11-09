import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/theme.dart';

class AssignBubble extends StatelessWidget {
  final String time;
  final String assign;
  const AssignBubble({super.key, required this.assign, required this.time});

  @override
  Widget build(BuildContext context) {
    double size = Get.width + Get.height;
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: 250,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: secondary.withOpacity(0.2)),
              child: Text(
                assign,
                style: TextStyle(color: Colors.black87, fontSize: size * 0.01),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Text(
            time,
            style: TextStyle(fontSize: 10, color: Colors.grey, height: 1.5),
          ),
        ],
      ),
    );
  }
}
