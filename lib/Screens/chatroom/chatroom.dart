// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:post/Screens/chatroom/chatroom_controller.dart';
import 'package:post/Screens/chatroom/widget/assign/assign_dialog.dart';
import 'package:post/Screens/chatroom/widget/custom_appbar_chatroom.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:post/Screens/chatroom/widget/keyboard.dart';
import 'package:post/controller/c_user.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';
import 'widget/button.dart';
import 'widget/close_dialog.dart';
import 'widget/left_buble/left_bubble.dart';
import 'widget/right_bubble/right_bubble.dart';

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
    required this.schedule,
    required this.fromWhere,
    required this.emailSender,
    required this.jarakWaktu,
    required this.assign,
    required this.imageProfileSender,
    required this.positionSender,
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
  final String schedule;
  final int jarakWaktu;
  // final String image;

  @override
  _ChatroomState createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom>
    with SingleTickerProviderStateMixin {
  Animatable<Color?> bgColor = TweenSequence<Color?>([
    TweenSequenceItem(
        tween: ColorTween(begin: Colors.white, end: Colors.blue.shade100),
        weight: 1.0),
    TweenSequenceItem(
        tween: ColorTween(begin: Colors.blue.shade100, end: Colors.white),
        weight: 1.0),
    TweenSequenceItem(
        tween: ColorTween(begin: Colors.white, end: Colors.blue.shade100),
        weight: 1.0),
    TweenSequenceItem(
        tween: ColorTween(begin: Colors.blue.shade100, end: Colors.white),
        weight: 1.0),
  ]);
  late AnimationController _controller;
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
    _controller = AnimationController(
        duration: const Duration(seconds: 2),
        vsync: this,
        reverseDuration: Duration(seconds: 2))
      ..repeat(reverse: true);
    Future.delayed(
      Duration.zero,
      () {
        Provider.of<ChatRoomController>(context, listen: false).changeStatus(
            widget.statusTask, widget.penerimaTask, widget.assign.last);
        print(Provider.of<ChatRoomController>(context, listen: false).status);
      },
    );
    super.initState();
    // cAccepted.setData(widget.statusTask);
    // cAccepted.setSender(widget.penerimaTask);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatRoomController>(context, listen: false);
    final app = AppLocalizations.of(context);
    double widht = Get.width;
    double height = Get.height;
    return Scaffold(
        appBar: PreferredSize(
            child: Consumer<ChatRoomController>(
              builder: (context, value, child) {
                return ChatRoomAppbar(
                    imageProfileSender: widget.imageProfileSender,
                    sender: widget.nameSender,
                    positionSender: widget.positionSender,
                    title: "${widget.tilteTask}",
                    lokasi: "${widget.location}",
                    schedule: widget.schedule,
                    assigned: widget.assign);
              },
            ),
            preferredSize: Size.fromHeight(height * 0.16)),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Hotel List')
                      .doc(widget.hotelid)
                      .collection('tasks')
                      .doc(widget.taskId)
                      .snapshots(includeMetadataChanges: true),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      var commentList = (snapshot.data!.data()
                          as Map<String, dynamic>)['comment'] as List;

                      print("-----------------------------");
                      return ListView.builder(
                        reverse: false,
                        padding: EdgeInsets.all(0),
                        controller: scrollController,
                        itemCount: commentList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              snapshot.data!['comment'][index]['senderemail'] ==
                                      auth.currentUser!.email
                                  ? rightBubble(
                                      commentList,
                                      context,
                                      snapshot.data!['comment'][index]['time'],
                                      snapshot.data!['comment'][index]
                                          ['sender'],
                                      snapshot.data!['comment'][index]
                                          ['commentBody'],
                                      snapshot.data!['comment'][index]
                                          ['accepted'],
                                      snapshot.data!['comment'][index]['esc'],
                                      snapshot.data!['comment'][index]
                                          ['assignTask'],
                                      snapshot.data!['comment'][index]
                                          ['assignTo'],
                                      snapshot.data!['comment'][index]
                                          ['imageComment'])
                                  : leftBubble(
                                      commentList,
                                      context,
                                      snapshot.data!['comment'][index]['time'],
                                      snapshot.data!['comment'][index]
                                          ['sender'],
                                      snapshot.data!['comment'][index]
                                          ['commentBody'],
                                      snapshot.data!['comment'][index]
                                          ['accepted'],
                                      snapshot.data!['comment'][index]['esc'],
                                      snapshot.data!['comment'][index]
                                          ['assignTask'],
                                      snapshot.data!['comment'][index]
                                          ['assignTo'],
                                      snapshot.data!['comment'][index]
                                          ['imageComment']),
                            ],
                          );
                        },
                      );
                    }
                    return SizedBox();
                  },
                ),
              )),
              SizedBox(
                // height: height * 0.15,
                width: widht,
                child: Consumer<ChatRoomController>(
                  builder: (context, value, child) => AnimatedSwitcher(
                    switchInCurve: Curves.easeInSine,
                    switchOutCurve: Curves.easeOutSine,
                    duration: Duration(seconds: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.04,
                          width: widht,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              value.status == "Close"
                                  ? SizedBox()
                                  : button(app!.close, () {
                                      closeDialog(
                                          context,
                                          widget.taskId,
                                          widget.location,
                                          widget.tilteTask,
                                          scrollController,
                                          widget.emailSender,
                                          widget.sendTo);
                                    }, widget.statusTask),
                              value.status == "Close"
                                  ? button(app!.reopen, () {
                                      provider.reopen(
                                          context,
                                          widget.taskId,
                                          widget.location,
                                          widget.tilteTask,
                                          scrollController,
                                          widget.sendTo);
                                    }, widget.statusTask)
                                  : button(app!.assign, () async {
                                      assign(
                                          context,
                                          widget.taskId,
                                          widget.emailSender,
                                          widget.location,
                                          widget.tilteTask,
                                          scrollController);
                                      await provider.getDeptartementAndNames();
                                    }, widget.statusTask),
                              value.status == "Close"
                                  ? SizedBox()
                                  : button(app.accept, () {
                                      value.receiver == cUser.data.name
                                          ? Fluttertoast.showToast(
                                              textColor: Colors.black,
                                              backgroundColor: Colors.white,
                                              msg:
                                                  "You have received this request")
                                          : provider.accept(
                                              context,
                                              widget.taskId,
                                              widget.emailSender,
                                              widget.location,
                                              widget.tilteTask,
                                              scrollController,
                                              widget.sendTo);
                                    }, widget.statusTask),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        value.status == "Close"
                            ? SizedBox()
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: keyboardChat(
                                    context,
                                    widget.taskId,
                                    widget.location,
                                    widget.tilteTask,
                                    scrollController,
                                    widget.fromWhere,
                                    widget.sendTo),
                              ),
                        // ignore: unrelated_type_equality_checks
                        value.images != null
                            ? Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      height: height * 0.06,
                                      width: widht * 0.6,
                                      child: Image.file(
                                        value.images!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                        left: 30,
                                        bottom: 15,
                                        child: CloseButton(
                                          color: Colors.grey,
                                          onPressed: () {
                                            provider.clearImage();
                                          },
                                        )),
                                    value.isImageLoad
                                        ? Positioned(
                                            left: 15,
                                            bottom: 7,
                                            child: CircularProgressIndicator(
                                              color: mainColor,
                                            ))
                                        : SizedBox(),
                                  ],
                                ),
                              )
                            : SizedBox()
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
