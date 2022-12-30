import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/chatroom/widget/action_area/widget/keyboard/widget/send_more_button.dart';
import 'widget/texfield.dart';

Widget keyboardChat({
  required BuildContext context,
  required String taskId,
  required String location,
  required String title,
  required ScrollController scroll,
  required String deptSender,
  required String emailSender,
  required String oldTime,
  required String oldDate,
  required String deptTujuan,
}) {
  return SizedBox(
    // height: MediaQuery.of(context).orientation == Orientation.landscape
    //     ? height * 0.08
    //     : height * 0.05,
    width: double.infinity,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: Get.width * 0.024,
        ),
        TextFieldArea(),
        SendAndMoreButton(
            taskId: taskId,
            location: location,
            title: title,
            emailSender: emailSender,
            deptTujuan: deptTujuan,
            deptSender: deptSender,
            oldTime: oldTime,
            oldDate: oldDate,
            scroll: scroll)
      ],
    ),
  );
}
