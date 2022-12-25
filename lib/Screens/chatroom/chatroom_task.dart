// ignore_for_file: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/chatroom/chatroom_controller.dart';
import 'package:post/Screens/chatroom/widget/task_appbar.dart';
import 'package:post/Screens/chatroom/widget/pop_up_menu/pop_up_menu_provider.dart';
import 'package:post/Screens/create/create_request_controller.dart';
import 'package:post/controller/c_user.dart';
import 'package:provider/provider.dart';
import '../../global_function.dart';
import 'widget/stream_tasks_chat.dart';

class ChatRoomTask extends StatefulWidget {
  const ChatRoomTask({
    required this.taskId,
    required this.nameSender,
    required this.tilteTask,
    required this.descriptionTask,
    required this.statusTask,
    required this.penerimaTask,
    required this.location,
    required this.time,
    required this.hotelid,
    required this.sendTo,
    required this.setDate,
    required this.fromWhere,
    required this.emailSender,
    required this.jarakWaktu,
    required this.assign,
    required this.imageProfileSender,
    required this.positionSender,
    required this.setTime,
    // required this.image,
  });
  final String taskId;
  final List<dynamic> assign;
  final String sendTo;
  final String imageProfileSender;
  final String positionSender;
  final String emailSender;
  final String location;
  final String nameSender;
  final String tilteTask;
  final String descriptionTask;
  final String statusTask;
  final String penerimaTask;
  final String hotelid;
  final DateTime time;
  final String fromWhere;
  final String setDate;
  final String setTime;
  final int jarakWaktu;
  // final String image;

  @override
  _ChatRoomTaskState createState() => _ChatRoomTaskState();
}

class _ChatRoomTaskState extends State<ChatRoomTask> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final scrollController = ScrollController();
  final cUser = Get.put(CUser());

  @override
  void initState() {
    
    Future.delayed(
      Duration.zero,
      () {
        Provider.of<CreateRequestController>(context, listen: false)
            .changeDate(widget.setDate.toString());
        Provider.of<CreateRequestController>(context, listen: false)
            .changeTime(widget.setTime.toString());
        Provider.of<PopUpMenuProvider>(context, listen: false)
            .changelocation(widget.location);
        Provider.of<ChatRoomController>(context, listen: false).changeStatus(
            widget.statusTask,
            widget.penerimaTask,
            widget.assign.isEmpty ? "" : widget.assign.last);
      },
    );
    Provider.of<GlobalFunction>(context, listen: false)
        .checkInternetConnetction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    return Scaffold(
        appBar: PreferredSize(
            child: Consumer<ChatRoomController>(
              builder: (context, value, child) {
                return TaskAppBar(
                    imageProfileSender: widget.imageProfileSender,
                    sender: widget.nameSender,
                    positionSender: widget.positionSender,
                    lokasi: Provider.of<PopUpMenuProvider>(context).location,
                    assigned: widget.assign,
                    sendTo: widget.sendTo,
                    timeCreated: widget.time,
                    taskId: widget.taskId,
                    emailSender: widget.emailSender,
                    oldDate: widget.setDate,
                    oldTime: widget.setTime,
                    titleTask: widget.tilteTask);
              },
            ),
            preferredSize: Size.fromHeight(height * 0.165)),
        body:StreamTasksChat(
                taskId: widget.taskId,
                assignLIst: widget.assign,
                sendTo: widget.sendTo,
                imageProfileSender: widget.imageProfileSender,
                positionSender: widget.positionSender,
                emailSender: widget.emailSender,
                location: widget.location,
                nameSender: widget.nameSender,
                tilteTask: widget.tilteTask,
                descriptionTask: widget.descriptionTask,
                statusTask: widget.statusTask,
                penerimaTask: widget.penerimaTask,
                hotelid: widget.hotelid,
                time: widget.time,
                fromWhere: widget.fromWhere,
                schedule: widget.setDate.toString()));
  }
}
