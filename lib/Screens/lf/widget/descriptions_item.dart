import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DescriptionItem extends StatelessWidget {
  final String description;
  const DescriptionItem({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: Get.width,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description:',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: Get.height * 0.01),
          Text(
            description,
            style: TextStyle(color: Colors.grey, height: 1.5),
          ),
        ],
      ),
    );
  }
}
