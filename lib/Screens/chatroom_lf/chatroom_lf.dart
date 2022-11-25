import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widget/appbar_lf_chatroom.dart';

class ChatRoomLf extends StatelessWidget {
  final Map<String, dynamic> data;
  const ChatRoomLf({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    return Scaffold(
      appBar: PreferredSize(
          child: AppBarLfChatRoom(
              imageProfileSender: data['profileImageSender'],
              positionSender: data["positionSender"],
              lokasi: data["location"],
              timeCreated: data["time"],
              image: data["image"],
              founder: data["founder"],
              nameItem: data["nameItem"],
              status: data["status"], receiver: data["receiveBy"]),
          preferredSize: Size.fromHeight(height * 0.165)),
    );
  }
}
