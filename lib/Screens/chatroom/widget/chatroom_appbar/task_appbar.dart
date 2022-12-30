import 'package:flutter/material.dart';

import 'package:post/Screens/chatroom/widget/chatroom_appbar/widget/component_client_appbar.dart';

import 'package:post/common_widget/card.dart';

import 'widget/component_sender_appbar.dart';

class TaskAppBar extends StatelessWidget {
  final String imageProfileSender;
  final String emailSender;
  final String sender;
  final String positionSender;
  final String lokasi;
  final String titleTask;
  final String sendTo;
  final String taskId;
  final DateTime timeCreated;
  // final String image;
  final List<dynamic> assigned;
  const TaskAppBar({
    super.key,
    required this.imageProfileSender,
    required this.sender,
    required this.positionSender,
    required this.lokasi,
    // required this.image,
    required this.assigned,
    required this.sendTo,
    required this.timeCreated,
    required this.taskId,
    required this.emailSender,
    required this.titleTask,
  });

  @override
  Widget build(BuildContext context) {
    return sender == cUser.data.name
        ? ComponentSenderAppBar(
            sendTo: sendTo,
            timeCreated: timeCreated,
            emailSender: emailSender,
            location: lokasi,
            taskId: taskId,
          )
        : ComponentClientAppBar(
            sendTo: sendTo,
            timeCreated: timeCreated,
            taskId: taskId,
            emailSender: emailSender,
            location: lokasi,
            imageProfileSender: imageProfileSender,
            positionSender: positionSender,
            senderName: sender,
          );
  }
}
