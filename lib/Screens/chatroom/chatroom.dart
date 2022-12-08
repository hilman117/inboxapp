// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/chatroom/chatroom_controller.dart';
import 'package:post/Screens/chatroom/widget/custom_appbar_chatroom.dart';
import 'package:post/Screens/chatroom/widget/pop_up_menu/pop_up_menu_provider.dart';
import 'package:post/Screens/create/create_request_controller.dart';
import 'package:post/controller/c_user.dart';
import 'package:provider/provider.dart';
import 'widget/stream_chatroom/stream_lf_chat.dart';
import 'widget/stream_chatroom/stream_tasks_chat.dart';

class Chatroom extends StatefulWidget {
  const Chatroom({
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
  _ChatroomState createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final scrollController = ScrollController();
  final cUser = Get.put(CUser());
  bool isTyping = false;
  String? taskTitle;
  String? sendTo;
  String? locationTask;
  String? acceptedby;
  String? scheduleTask;
  String? descriptionTask;
  String? statusTask;
  String? timeTask;
  String? imageTask;
  String? senderImage;
  String? receiver;
  String? emailSender;
  bool isUpdated = false;
  bool isScheduled = false;

  bool isSender = true;
  bool isLoading = false;
  late File image;
  String imageName = '';
  String imageUrl = "";
  //  waktu =
  // int jarakWaktu = DateTime.now().difference(widget.time).inMinutes;

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () {
        Provider.of<CreateRequestController>(context, listen: false)
            .changeDate(widget.setDate);
        Provider.of<CreateRequestController>(context, listen: false)
            .changeTime(widget.setTime);
        Provider.of<PopUpMenuProvider>(context, listen: false)
            .changelocation(widget.location);
        Provider.of<ChatRoomController>(context, listen: false).changeStatus(
            widget.statusTask,
            widget.penerimaTask,
            widget.assign.isEmpty ? "" : widget.assign.last);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    return Scaffold(
        appBar: PreferredSize(
            child: Consumer<ChatRoomController>(
              builder: (context, value, child) {
                return ChatRoomAppbar(
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
        body: widget.assign.isNotEmpty
            ? StreamTasksChat(
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
                schedule: widget.setDate)
            : StreamLfChat(
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
                schedule: widget.setDate));
  }
}
