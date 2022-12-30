import 'package:flutter/material.dart';
import 'package:post/Screens/chatroom/chatroom_controller.dart';
import 'package:provider/provider.dart';

import '../../../../../service/theme.dart';
import '../../../../../common_widget/card.dart';

Widget buttonAction(String buttonName, VoidCallback callback, String status) =>
    Consumer<ChatRoomController>(
        builder: (context, value, child) => Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: value.status == "Close" ? 10 : 5),
                height:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? height * 0.2
                        : height * 0.04,
                //  width: status Get.width * 0.30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // <-- Radius
                    ),
                  ),
                  onPressed: value.status != "Hold" ? callback : null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(buttonName),
                  ),
                ),
              ),
            ));
