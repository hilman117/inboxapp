import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../multiple_photos.dart';

class LeftMessage extends StatelessWidget {
  final List<dynamic> commentList;
  final String senderMsgName;
  final String time;
  final String message;
  // final String description;
  final List<dynamic> image;
  const LeftMessage(
      {required this.commentList,
      required this.time,
      required this.message,
      // required this.description,
      required this.image,
      required this.senderMsgName});

  @override
  Widget build(BuildContext context) {
    Color finalCOlor =
        Colors.primaries[Random().nextInt(Colors.primaries.length)].shade900;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  right: Get.width * 0.1,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(16),
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                    color: finalCOlor.withOpacity(0.1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          senderMsgName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: finalCOlor),
                        ),
                        SizedBox(
                          height: Get.height * 0.009,
                        ),
                        message.isNotEmpty
                            ? Text(
                                message,
                                style: TextStyle(color: Colors.black87),
                                overflow: TextOverflow.clip,
                              )
                            : SizedBox(),
                        SizedBox(
                            height: image.isEmpty ? 0 : Get.height * 0.015),
                        image.isEmpty
                            ? SizedBox()
                            : MultiplePhoto(images: image)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: Get.width * 0.1,
            child: Text(
              time,
              style: TextStyle(fontSize: 10, color: Colors.grey, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
