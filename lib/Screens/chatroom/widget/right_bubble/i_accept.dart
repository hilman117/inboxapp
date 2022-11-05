import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Iaccept extends StatelessWidget {
  final String isAccepted;
  final String time;
  const Iaccept({required this.isAccepted, required this.time});

  @override
  Widget build(BuildContext context) {
    double size = Get.width + Get.height;
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: size * 0.25,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.green.shade50),
                  child: Text(
                    isAccepted,
                    style: TextStyle(
                        color: Colors.black87, fontSize: size * 0.009),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ],
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
