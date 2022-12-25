import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/chatroom/chatroom_controller.dart';
import 'package:post/Screens/chatroom/widget/image_picker.dart';
import 'package:post/global_function.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../service/theme.dart';

Widget keyboardChat(
  {required BuildContext context,
  required String taskId,
  required String location,
  required String title,
  required ScrollController scroll,
  required String deptSender,
  required String deptTujuan,}
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
                  child: value.isTypping || value.imagesList.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            if (Provider.of<GlobalFunction>(context,
                                        listen: false)
                                    .hasInternetConnection ==
                                true) {
                              Provider.of<ChatRoomController>(context,
                                      listen: false)
                                  .sendComment(taskId, location, title, scroll,
                                      deptSender, deptTujuan);
                            } else {
                              Provider.of<GlobalFunction>(context,
                                      listen: false)
                                  .noInternet();
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
