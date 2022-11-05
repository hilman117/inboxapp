import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/chatroom/chatroom_controller.dart';
import 'package:post/Screens/chatroom/widget/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../service/theme.dart';

Widget keyboardChat(
    BuildContext context,
    String taskId,
    String location,
    String title,
    ScrollController scroll,
    String deptSender,
    String deptTujuan) {
  return SizedBox(
    height: Get.height * 0.05,
    width: double.infinity,
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            height: 40,
            child: TextFormField(
              controller:
                  Provider.of<ChatRoomController>(context, listen: false)
                      .commentBody,
              cursorColor: mainColor,
              textAlignVertical: TextAlignVertical.center,
              cursorHeight: 14,
              onChanged: (value) {
                Provider.of<ChatRoomController>(context, listen: false)
                    .typing(value);
              },
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              minLines: 1,
              maxLines: 5,
              style: const TextStyle(fontSize: 14, overflow: TextOverflow.clip),
              decoration: InputDecoration(
                hintText: "type here...",
                hintStyle: const TextStyle(fontSize: 14),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                prefixIcon: IconButton(
                  onPressed: () {
                    imagePicker(context, Get.height, Get.width);
                  },
                  icon: Icon(
                    Icons.camera_alt_rounded,
                    color: mainColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: mainColor, width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: mainColor, width: 1)),
              ),
            ),
          ),
        ),
        Consumer<ChatRoomController>(
            builder: (context, value, child) => AnimatedSwitcher(
                duration: Duration.zero,
                switchOutCurve: Curves.easeOutSine,
                child: value.isTypping || value.images != null
                    ? Container(
                        height: Get.height * 0.05,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: mainColor),
                        padding: const EdgeInsets.all(5),
                        child: IconButton(
                            padding: const EdgeInsets.all(0),
                            splashRadius: 20,
                            onPressed: () {
                              Provider.of<ChatRoomController>(context,
                                      listen: false)
                                  .sendComment(taskId, location, title, scroll,
                                      deptSender, deptTujuan);
                            },
                            icon: const Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 25,
                            )))
                    : Container(
                        height: Get.height * 0.05,
                        padding: const EdgeInsets.all(5),
                        child: IconButton(
                            padding: const EdgeInsets.all(0),
                            splashRadius: 20,
                            onPressed: () {},
                            icon: Icon(
                              Icons.more_vert,
                              color: mainColor,
                              size: 25,
                            )))))
      ],
    ),
  );
}
