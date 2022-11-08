import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';

import '../../../../service/theme.dart';
import '../imageRoom.dart';

class MyMessage extends StatelessWidget {
  final List<dynamic> commentList;
  final String senderMsgName;
  final String time;
  final String message;
  // final String description;
  final String image;
  const MyMessage(
      {required this.commentList,
      required this.time,
      required this.message,
      // required this.description,
      required this.image,
      required this.senderMsgName});

  @override
  Widget build(BuildContext context) {
    String idImage = Uuid().v4();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 40,
            child: Text(
              time,
              style: TextStyle(fontSize: 10, color: Colors.grey, height: 1.5),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                    color: secondary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          senderMsgName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(
                          height: Get.height * 0.009,
                        ),
                        Text(
                          message,
                          style: TextStyle(color: Colors.white),
                          overflow: TextOverflow.clip,
                        ),
                        // description.isEmpty
                        //     ? SizedBox()
                        //     : Text(
                        //         description,
                        //         style: TextStyle(color: Colors.white),
                        //       ),
                        // SizedBox(
                        //   height: description == '' ? 0 : 5,
                        // ),
                        image.isEmpty
                            ? SizedBox()
                            : GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    final listImage = commentList
                                        .where((element) =>
                                            element['imageComment'] != '')
                                        .toList();
                                    return PageView.builder(
                                      pageSnapping: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: listImage.length,
                                      itemBuilder: (context, index) {
                                        var imageItem = listImage[index];
                                        return ImageRoom(
                                            image: imageItem['imageComment'],
                                            id: idImage);
                                      },
                                    );
                                  }));
                                },
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  child: Hero(
                                    tag: idImage,
                                    child: image.isEmpty
                                        ? Lottie.asset("images/loader.json")
                                        : Image.network(
                                            image,
                                            width: 170,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              )
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
