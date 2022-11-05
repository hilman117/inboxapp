import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';

import 'imageRoom.dart';

Widget leftBubble(
    List<dynamic> commentList,
    BuildContext context,
    String time,
    String senderMsgName,
    String message,
    String description,
    String isAccepted,
    String esc,
    String assign,
    String image) {
  List<Color> container = [
    Colors.green.shade50,
    Colors.red.shade50,
    Colors.blue.shade50,
    Colors.purple.shade50,
    Colors.orange.shade50,
    Colors.brown.shade50,
    Colors.deepPurple.shade50,
    Colors.grey.shade200,
    Colors.indigo.shade50,
    Colors.pink.shade50,
    Colors.teal.shade50,
  ];

  String idImage = Uuid().v4();

  Color color = Colors.primaries[Random().nextInt(container.length)].shade900;
  return Column(
    //buble chat yg tampil jika ada org sbg pengirim pesan..................................
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      (isAccepted != '')
          ? SizedBox()
          : (assign != '')
              ? SizedBox()
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 30,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: color.withOpacity(0.07)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      senderMsgName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: color),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.009,
                                    ),
                                    Text(
                                      message,
                                      style: TextStyle(color: Colors.black87),
                                      overflow: TextOverflow.clip,
                                    ),
                                    description.isEmpty
                                        ? SizedBox()
                                        : Text(
                                            description,
                                            style: TextStyle(
                                                color: Colors.black87),
                                          ),
                                    SizedBox(
                                      height: description == '' ? 0 : 5,
                                    ),
                                    image.isEmpty
                                        ? SizedBox()
                                        : GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                final listImage = commentList
                                                    .where((element) =>
                                                        element[
                                                            'imageComment'] !=
                                                        '')
                                                    .toList();
                                                return PageView.builder(
                                                  pageSnapping: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: listImage.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var imageItem =
                                                        listImage[index];
                                                    return ImageRoom(
                                                      image: imageItem[
                                                          'imageComment'],
                                                      id: idImage,
                                                    );
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
                                                    ? Lottie.asset(
                                                        "images/loader.json")
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
                      SizedBox(
                        width: 40,
                        child: Text(
                          time,
                          style: TextStyle(
                              fontSize: 10, color: Colors.grey, height: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),
      //widget pesan yg ditampilkan ketika status diterima............
      SizedBox(
        height: isAccepted == '' ? 0 : 20,
      ),
      (isAccepted == '')
          ? SizedBox()
          : (assign != '')
              ? SizedBox()
              : SizedBox(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 25,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 250,
                            child: Text(
                              isAccepted,
                              style: TextStyle(color: Colors.black87),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      SizedBox(
                        width: 40,
                        child: Text(
                          time,
                          style: TextStyle(
                              fontSize: 10, color: Colors.grey, height: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),
      SizedBox(
        height: isAccepted == '' ? 0 : 10,
      ),
      // widget yg ditampilkan ketika kita assign request ke user lain.......................
      SizedBox(
        height: assign == '' ? 0 : 10,
      ),
      assign == ''
          ? SizedBox()
          : SizedBox(
              width: double.infinity,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.person_pin,
                    color: Colors.blue,
                    size: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 250,
                        child: Text(
                          assign,
                          style: TextStyle(color: Colors.black87, height: 1.7),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  SizedBox(
                    width: 40,
                    child: Text(
                      time,
                      style: TextStyle(
                          fontSize: 10, color: Colors.grey, height: 1.5),
                    ),
                  ),
                ],
              ),
            ),
      SizedBox(
        height: assign == '' ? 0 : 10,
      ),
      // status esc................................
      SizedBox(
        height: esc == '' ? 0 : 10,
      ),
      esc == ''
          ? SizedBox()
          : SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 40,
                    child: Text(
                      "Jun 03, 09.00 AM",
                      style: TextStyle(
                          fontSize: 10, color: Colors.grey, height: 1.5),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        width: 250,
                        child: const Text(
                          "Escalation after 5 minutes",
                          style: TextStyle(color: Colors.black87),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.history,
                        color: Colors.blue,
                        size: 30,
                      ),

                      // Icon(
                      //   Icons.check_circle,
                      //   color: Colors.green,
                      // ),
                    ],
                  ),
                ],
              ),
            ),
      SizedBox(
        height: esc == '' ? 0 : 10,
      ),
    ],
  );
}
