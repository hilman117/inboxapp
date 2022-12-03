import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../service/theme.dart';
import '../multiple_photos.dart';

class MyMessage extends StatelessWidget {
  final List<dynamic> commentList;
  final String senderMsgName;
  final String time;
  final String message;
  // final String description;
  final List<dynamic> image;
  const MyMessage(
      {required this.commentList,
      required this.time,
      required this.message,
      // required this.description,
      required this.image,
      required this.senderMsgName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: Get.width * 0.1,
            child: Text(
              time,
              style: TextStyle(fontSize: 10, color: Colors.grey, height: 1.5),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(
                  left: Get.width * 0.1,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                    color: mainColor.withOpacity(0.1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          senderMsgName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        SizedBox(
                          height: Get.height * 0.009,
                        ),
                        message.isNotEmpty
                            ? SelectableText(
                                message,
                                style: TextStyle(color: Colors.black87),
                              )
                            : SizedBox(),
                        SizedBox(
                            height: image.isEmpty ? 0 : Get.height * 0.015),
                        image.isEmpty
                            ? SizedBox()
                            : SizedBox(
                                height: 200,
                                width: 200,
                                child: MultiplePhoto(images: image))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
