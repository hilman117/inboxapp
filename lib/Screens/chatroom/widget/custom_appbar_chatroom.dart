import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/chatroom/chatroom_controller.dart';
import 'package:provider/provider.dart';

import '../../dasboard/widget/animated/status.dart';

Widget chatroomAppbar(String status, String receiver, String title,
        String lokasi, String image, List<dynamic> assigned) =>
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  "images/$image.png",
                  width: Get.width * 0.05,
                  fit: BoxFit.fill,
                ),
                SizedBox(width: Get.width * 0.03),
                SizedBox(
                  width: Get.width * 0.50,
                  child: Text(
                    lokasi,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            StatusWidget(
              status: status,
              isFading: false,
            ),
          ],
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: Get.width * 0.40,
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
                overflow: TextOverflow.clip,
              ),
            ),
            SizedBox(
              width: Get.width * 0.50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    (receiver == '')
                        ? ""
                        : (status == 'Assigned')
                            ? "to"
                            : 'by',
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                        color: Colors.white),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                  Consumer<ChatRoomController>(
                      builder: (context, value, child) => Flexible(
                            child: Text(
                              status == 'Assigned'
                                  ? value.receiver
                                  : "$receiver",
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13,
                                  color: Colors.white),
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.clip,
                            ),
                          ))
                ],
              ),
            ),
          ],
        ),
      ],
    );
