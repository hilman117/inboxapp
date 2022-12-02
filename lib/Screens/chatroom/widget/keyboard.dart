import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/chatroom/chatroom_controller.dart';
import 'package:post/Screens/chatroom/widget/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../service/theme.dart';

Widget keyboardChat(
  BuildContext context,
  String taskId,
  String location,
  String title,
  ScrollController scroll,
  String deptSender,
  String deptTujuan,
  String reportCreator,
  String creatorEmail,
) {
  return SizedBox(
    height: Get.height * 0.05,
    width: double.infinity,
    child: Row(
      children: [
        SizedBox(
          width: Get.width * 0.024,
        ),
        Container(
          decoration: BoxDecoration(
              color: mainColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8)),
          width: Get.width * 0.8,
          padding: const EdgeInsets.symmetric(horizontal: 0),
          height: 40,
          child: TextFormField(
            controller: Provider.of<ChatRoomController>(context, listen: false)
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
              isDense: true,
              border: InputBorder.none,
              hintText: AppLocalizations.of(context)!.typeHere,
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
            ),
          ),
        ),
        SizedBox(
          width: Get.width * 0.02,
        ),
        Consumer<ChatRoomController>(
            builder: (context, value, child) => AnimatedSwitcher(
                  duration: Duration.zero,
                  switchOutCurve: Curves.easeOutSine,
                  child: value.isTypping || value.images != null
                      ? GestureDetector(
                          onTap: () {
                            if (deptTujuan.isEmpty) {
                              Provider.of<ChatRoomController>(context,
                                      listen: false)
                                  .sendCommentForLostAndFound(
                                      taskId,
                                      location,
                                      title,
                                      scroll,
                                      deptSender,
                                      deptTujuan,
                                      reportCreator,
                                      creatorEmail);
                              
                            } else {
                              Provider.of<ChatRoomController>(context,
                                      listen: false)
                                  .sendComment(taskId, location, title, scroll,
                                      deptSender, deptTujuan);
                            }
                          },
                          child: Container(
                              height: Get.height * 0.05,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent),
                              padding: const EdgeInsets.all(5),
                              child: Image.asset('images/send1.png')),
                        )
                      : Container(
                          height: Get.height * 0.05,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent),
                          padding: const EdgeInsets.all(5),
                          child: Image.asset('images/send2.png')),
                ))
      ],
    ),
  );
}
