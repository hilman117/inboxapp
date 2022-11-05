import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IAssign extends StatelessWidget {
  final String time;
  final String assign;
  const IAssign({super.key, required this.assign, required this.time});

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
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.blue.shade50),
              child: Text(
                assign,
                style: TextStyle(color: Colors.black87, fontSize: size * 0.009),
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
