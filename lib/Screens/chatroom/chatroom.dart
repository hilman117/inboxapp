// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:post/Screens/chatroom/chatroom_controller.dart';
import 'package:post/Screens/chatroom/widget/assign/assign_dialog.dart';
import 'package:post/Screens/chatroom/widget/keyboard.dart';
import 'package:post/controller/c_user.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';
import 'widget/button.dart';
import 'widget/close_dialog.dart';
import 'widget/custom_appbar_chatroom.dart';
import 'widget/left_bubble.dart';
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
    // required this.image,
  });
  final String taskId;
  final List<dynamic> assign;
  final String sendTo;
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
        Provider.of<ChatRoomController>(context, listen: false)
            .changeStatus(widget.statusTask, widget.penerimaTask);
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
    double widht = Get.width;
    double height = Get.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Consumer<ChatRoomController>(
            builder: (context, value, child) {
              return chatroomAppbar(
                  value.status,
                  value.receiver,
                  "${widget.tilteTask}",
                  "${widget.location}",
                  "${widget.sendTo}",
                  widget.assign);
            },
          ),
        ),
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
                                          ['description'],
                                      snapshot.data!['comment'][index]
                                          ['accepted'],
                                      snapshot.data!['comment'][index]['esc'],
                                      snapshot.data!['comment'][index]
                                          ['assignTask'],
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
                                          ['description'],
                                      snapshot.data!['comment'][index]
                                          ['accepted'],
                                      snapshot.data!['comment'][index]['esc'],
                                      snapshot.data!['comment'][index]
                                          ['assignTask'],
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
                                  : button("Close", () {
                                      closeDialog(
                                          context,
                                          widget.taskId,
                                          widget.location,
                                          widget.tilteTask,
                                          scrollController,
                                          widget.emailSender,
                                          widget.sendTo);
                                    }),
                              value.status == "Close"
                                  ? button("Reopen", () {
                                      provider.reopen(
                                          context,
                                          widget.taskId,
                                          widget.location,
                                          widget.tilteTask,
                                          scrollController,
                                          widget.sendTo);
                                    })
                                  : button("Assign", () async {
                                      await provider.getDeptartement();
                                      await provider.getNames();
                                      assign(
                                          context,
                                          widget.taskId,
                                          widget.emailSender,
                                          widget.location,
                                          widget.tilteTask,
                                          scrollController);
                                    }),
                              value.status == "Close"
                                  ? SizedBox()
                                  : button("Accept", () {
                                      value.receiver == cUser.data.name
                                          ? Fluttertoast.showToast(
                                              textColor: Colors.black,
                                              backgroundColor: Colors.white,
                                              msg:
                                                  "You have received this request")
                                          : provider.accept(
                                              widget.taskId,
                                              widget.emailSender,
                                              widget.location,
                                              widget.tilteTask,
                                              scrollController,
                                              widget.sendTo);
                                    }),
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
                                              color: Colors.orange,
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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SafeArea(
  //         child: Column(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
  //           child: Container(
  //             decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(16),
  //                 boxShadow: [
  //                   BoxShadow(
  //                     color: Colors.grey.withOpacity(0.5),
  //                     spreadRadius: 1,
  //                     blurRadius: 3,
  //                     // offset: Offset(), // changes position of shadow
  //                   ),
  //                 ]),
  //             width: double.infinity,
  //             child: Padding(
  //               padding: const EdgeInsets.all(5.0),
  //               child: Row(
  //                 children: [
  //                   InkWell(
  //                     radius: 20,
  //                     onTap: () => Get.back(),
  //                     child: Material(
  //                       shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(50)),
  //                       child: Icon(
  //                         Icons.arrow_back_ios_new,
  //                         color: Color(0xff007dff),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(width: 5),
  //                   Expanded(
  //                     child: Container(
  //                       child: Padding(
  //                         padding: const EdgeInsets.symmetric(horizontal: 3),
  //                         child: Column(
  //                           children: [
  //                             Row(
  //                               mainAxisSize: MainAxisSize.max,
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Image.asset(
  //                                   "images/${widget.sendTo}.png",
  //                                   width: 20,
  //                                 ),
  //                                 SizedBox(
  //                                   width: 6,
  //                                 ),
  //                                 Container(
  //                                   width: 230,
  //                                   child: Text(
  //                                     widget.tilteTask,
  //                                     style: TextStyle(fontSize: 16),
  //                                     overflow: TextOverflow.clip,
  //                                   ),
  //                                 ),
  //                                 Spacer(),
  //                                 Obx(() {
  //                                   return StatusWidget(
  //                                       status: widget.jarakWaktu >= 5 &&
  //                                               cAccepted.data == "New"
  //                                           ? "ESC"
  //                                           : cAccepted.data);
  //                                 })
  //                               ],
  //                             ),
  //                             SizedBox(height: 3),
  //                             Row(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Container(
  //                                   width: 150,
  //                                   child: Text(
  //                                     widget.location,
  //                                     style: TextStyle(fontSize: 13),
  //                                     overflow: TextOverflow.clip,
  //                                   ),
  //                                 ),
  //                                 Spacer(),
  //                                 Container(
  //                                   width: 170,
  //                                   child: Obx(() {
  //                                     return Text(
  //                                       cAccepted.sender,
  //                                       style: TextStyle(
  //                                           fontSize: 12, color: Colors.blue),
  //                                       overflow: TextOverflow.clip,
  //                                       textAlign: TextAlign.end,
  //                                     );
  //                                   }),
  //                                 ),
  //                               ],
  //                             ),
  //                             SizedBox(
  //                               height: 5,
  //                             ),
  //                             if (widget.schedule != '')
  //                               Row(
  //                                 children: [
  //                                   Icon(Icons.alarm,
  //                                       color: Colors.red, size: 15),
  //                                   SizedBox(
  //                                     width: 5,
  //                                   ),
  //                                   Container(
  //                                     width: 300,
  //                                     child: Text(
  //                                       widget.schedule,
  //                                       overflow: TextOverflow.clip,
  //                                       style: TextStyle(color: Colors.red),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           child: Container(
  //             width: double.infinity,
  //             // color: Colors.blue,
  //             child: StreamBuilder<DocumentSnapshot>(
  //               stream: FirebaseFirestore.instance
  //                   .collection('Hotel List')
  //                   .doc(widget.hotelid)
  //                   .collection('tasks')
  //                   .doc(widget.taskId)
  //                   .snapshots(includeMetadataChanges: true),
  //               builder: (context, snapshot) {
  //                 String hotel = widget.hotelid;
  //                 print(hotel);
  //                 if (snapshot.connectionState == ConnectionState.active) {
  //                   var commentList = (snapshot.data!.data()
  //                       as Map<String, dynamic>)['comment'] as List;
  //                   print("-----------------------------");
  //                   return ListView.builder(
  //                       controller: scrollController,
  //                       itemCount: commentList.length,
  //                       itemBuilder: (context, index) => Column(
  //                             children: [
  //                               Padding(
  //                                   padding: const EdgeInsets.symmetric(
  //                                       horizontal: 20, vertical: 5),
  //                                   child:
  //                                       snapshot.data!['comment'][index]
  //                                                   ['senderemail'] ==
  //                                               auth.currentUser!.email
  //                                           ? Column(
  //                                               //buble chat yg tampil jika ada kita sbg pengirim pesan..................................
  //                                               crossAxisAlignment:
  //                                                   CrossAxisAlignment.end,
  //                                               children: [
  //                                                 if (snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['accepted'] ==
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['assignTask'] ==
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                             [index]['esc'] ==
  //                                                         '')
  //                                                   Row(
  //                                                     mainAxisAlignment:
  //                                                         MainAxisAlignment
  //                                                             .spaceBetween,
  //                                                     children: [
  //                                                       Container(
  //                                                         width: 40,
  //                                                         child: Text(
  //                                                           snapshot.data![
  //                                                                   'comment']
  //                                                               [index]['time'],
  //                                                           style: TextStyle(
  //                                                               fontSize: 10,
  //                                                               color:
  //                                                                   Colors.grey,
  //                                                               height: 1.5),
  //                                                         ),
  //                                                       ),
  //                                                       Expanded(
  //                                                         child: Container(
  //                                                           alignment: Alignment
  //                                                               .centerRight,
  //                                                           child: Padding(
  //                                                             padding:
  //                                                                 const EdgeInsets
  //                                                                     .only(
  //                                                               left: 30,
  //                                                             ),
  //                                                             child: Container(
  //                                                               decoration:
  //                                                                   BoxDecoration(
  //                                                                 borderRadius:
  //                                                                     BorderRadius
  //                                                                         .circular(
  //                                                                             16),
  //                                                                 color: Colors
  //                                                                     .grey
  //                                                                     .shade200,
  //                                                               ),
  //                                                               child: Padding(
  //                                                                 padding:
  //                                                                     const EdgeInsets
  //                                                                             .all(
  //                                                                         10.0),
  //                                                                 child: Column(
  //                                                                   crossAxisAlignment:
  //                                                                       CrossAxisAlignment
  //                                                                           .end,
  //                                                                   children: [
  //                                                                     Column(
  //                                                                       crossAxisAlignment:
  //                                                                           CrossAxisAlignment.start,
  //                                                                       children: [
  //                                                                         Text(
  //                                                                           snapshot.data!['comment'][index]['sender'],
  //                                                                           style:
  //                                                                               TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
  //                                                                         ),
  //                                                                         if (snapshot.data!['comment'][index]['commentBody'] !=
  //                                                                             '')
  //                                                                           SizedBox(
  //                                                                             height: 3,
  //                                                                           ),
  //                                                                         if (snapshot.data!['comment'][index]['commentBody'] !=
  //                                                                             '')
  //                                                                           Text(
  //                                                                             snapshot.data!['comment'][index]['commentBody'],
  //                                                                             style: TextStyle(color: Colors.black87),
  //                                                                             overflow: TextOverflow.clip,
  //                                                                           ),
  //                                                                         if (snapshot.data!['comment'][index]['description'] !=
  //                                                                             commentList[0])
  //                                                                           if (snapshot.data!['comment'][index]['description'] != '')
  //                                                                             Text(
  //                                                                               snapshot.data!['comment'][index]['description'],
  //                                                                               style: TextStyle(color: Colors.black87),
  //                                                                             ),
  //                                                                         if (snapshot.data!['comment'][index]['imageComment'] !=
  //                                                                             '')
  //                                                                           SizedBox(
  //                                                                             height: 5,
  //                                                                           ),
  //                                                                         if (snapshot.data!['comment'][index]['imageComment'] !=
  //                                                                             '')
  //                                                                           GestureDetector(
  //                                                                             onTap: () {
  //                                                                               Navigator.push(context, MaterialPageRoute(builder: (context) {
  //                                                                                 final listImage = commentList.where((element) => element['imageComment'] != '').toList();
  //                                                                                 return PageView.builder(
  //                                                                                   pageSnapping: true,
  //                                                                                   scrollDirection: Axis.horizontal,
  //                                                                                   itemCount: listImage.length,
  //                                                                                   itemBuilder: (context, index) {
  //                                                                                     var imageItem = listImage[index];
  //                                                                                     return ImageRoom(
  //                                                                                       image: imageItem['imageComment'],
  //                                                                                     );
  //                                                                                   },
  //                                                                                 );
  //                                                                               }));
  //                                                                             },
  //                                                                             child: Container(
  //                                                                               width: 80,
  //                                                                               height: 80,
  //                                                                               child: Hero(
  //                                                                                 tag: "imageHero",
  //                                                                                 child: Image.network(
  //                                                                                   snapshot.data!['comment'][index]['imageComment'],
  //                                                                                   width: 170,
  //                                                                                   fit: BoxFit.cover,
  //                                                                                 ),
  //                                                                               ),
  //                                                                             ),
  //                                                                           )
  //                                                                       ],
  //                                                                     ),
  //                                                                   ],
  //                                                                 ),
  //                                                               ),
  //                                                             ),
  //                                                           ),
  //                                                         ),
  //                                                       ),
  //                                                     ],
  //                                                   ),
  //                                                 //widget pesan yg ditampilkan ketika status diterima............
  //                                                 if (snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['accepted'] !=
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['assignTask'] ==
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                             [index]['esc'] ==
  //                                                         '')
  //                                                   SizedBox(
  //                                                     height: 10,
  //                                                   ),
  //                                                 if (snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['accepted'] !=
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['assignTask'] ==
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                             [index]['esc'] ==
  //                                                         '')
  //                                                   Container(
  //                                                     width: double.infinity,
  //                                                     child: Row(
  //                                                       mainAxisAlignment:
  //                                                           MainAxisAlignment
  //                                                               .spaceBetween,
  //                                                       children: [
  //                                                         Container(
  //                                                           width: 40,
  //                                                           child: Text(
  //                                                             snapshot.data![
  //                                                                     'comment']
  //                                                                 [
  //                                                                 index]['time'],
  //                                                             style: TextStyle(
  //                                                                 fontSize: 10,
  //                                                                 color: Colors
  //                                                                     .grey,
  //                                                                 height: 1.5),
  //                                                           ),
  //                                                         ),
  //                                                         Row(
  //                                                           children: [
  //                                                             Container(
  //                                                               width: 250,
  //                                                               child: Text(
  //                                                                 snapshot.data![
  //                                                                             'comment']
  //                                                                         [
  //                                                                         index]
  //                                                                     [
  //                                                                     'accepted'],
  //                                                                 style: TextStyle(
  //                                                                     color: Colors
  //                                                                         .black87),
  //                                                                 textAlign:
  //                                                                     TextAlign
  //                                                                         .end,
  //                                                               ),
  //                                                             ),
  //                                                             SizedBox(
  //                                                               width: 10,
  //                                                             ),
  //                                                             Icon(
  //                                                               Icons
  //                                                                   .check_circle,
  //                                                               size: 35,
  //                                                               color: Colors
  //                                                                   .green,
  //                                                             ),
  //                                                           ],
  //                                                         )
  //                                                       ],
  //                                                     ),
  //                                                   ),
  //                                                 if (snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['accepted'] !=
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['assignTask'] ==
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                             [index]['esc'] ==
  //                                                         '')
  //                                                   SizedBox(
  //                                                     height: 10,
  //                                                   ),
  //                                                 // widget yg ditampilkan ketika kita assign request ke user lain.......................
  //                                                 if (snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['accepted'] ==
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['assignTask'] !=
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                             [index]['esc'] ==
  //                                                         '')
  //                                                   SizedBox(
  //                                                     height: 10,
  //                                                   ),
  //                                                 if (snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['accepted'] ==
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['assignTask'] !=
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                             [index]['esc'] ==
  //                                                         '')
  //                                                   Container(
  //                                                     width: double.infinity,
  //                                                     child: Row(
  //                                                       mainAxisAlignment:
  //                                                           MainAxisAlignment
  //                                                               .spaceBetween,
  //                                                       children: [
  //                                                         Container(
  //                                                           width: 40,
  //                                                           child: Text(
  //                                                             snapshot.data![
  //                                                                     'comment']
  //                                                                 [
  //                                                                 index]['time'],
  //                                                             style: TextStyle(
  //                                                                 fontSize: 10,
  //                                                                 color: Colors
  //                                                                     .grey,
  //                                                                 height: 1.5),
  //                                                           ),
  //                                                         ),
  //                                                         Row(
  //                                                           children: [
  //                                                             Container(
  //                                                               width: 250,
  //                                                               child: Text(
  //                                                                 snapshot.data![
  //                                                                             'comment']
  //                                                                         [
  //                                                                         index]
  //                                                                     [
  //                                                                     'assignTask'],
  //                                                                 style: TextStyle(
  //                                                                     color: Colors
  //                                                                         .black87,
  //                                                                     height:
  //                                                                         1.7),
  //                                                                 textAlign:
  //                                                                     TextAlign
  //                                                                         .end,
  //                                                               ),
  //                                                             ),
  //                                                             SizedBox(
  //                                                               width: 10,
  //                                                             ),
  //                                                             Icon(
  //                                                               Icons
  //                                                                   .person_pin,
  //                                                               color:
  //                                                                   Colors.blue,
  //                                                               size: 40,
  //                                                             ),
  //                                                             // Icon(
  //                                                             //   Icons.check_circle,
  //                                                             //   color: Colors.green,
  //                                                             // ),
  //                                                           ],
  //                                                         )
  //                                                       ],
  //                                                     ),
  //                                                   ),
  //                                                 if (snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['accepted'] ==
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['assignTask'] !=
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                             [index]['esc'] ==
  //                                                         '')
  //                                                   SizedBox(
  //                                                     height: 10,
  //                                                   ),
  //                                                 // status esc................................
  //                                                 if (snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['accepted'] ==
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                             [index]['esc'] !=
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['assignTask'] ==
  //                                                         '')
  //                                                   SizedBox(
  //                                                     height: 10,
  //                                                   ),
  //                                                 if (snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['accepted'] ==
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                             [index]['esc'] !=
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['assignTask'] ==
  //                                                         '')
  //                                                   Container(
  //                                                     width: double.infinity,
  //                                                     child: Row(
  //                                                       mainAxisAlignment:
  //                                                           MainAxisAlignment
  //                                                               .spaceBetween,
  //                                                       children: [
  //                                                         Container(
  //                                                           width: 40,
  //                                                           child: Text(
  //                                                             snapshot.data![
  //                                                                     'comment']
  //                                                                 [
  //                                                                 index]['time'],
  //                                                             style: TextStyle(
  //                                                                 fontSize: 10,
  //                                                                 color: Colors
  //                                                                     .grey,
  //                                                                 height: 1.5),
  //                                                           ),
  //                                                         ),
  //                                                         Row(
  //                                                           children: [
  //                                                             Container(
  //                                                               alignment: Alignment
  //                                                                   .centerRight,
  //                                                               width: 250,
  //                                                               child: Text(
  //                                                                 snapshot.data![
  //                                                                         'comment']
  //                                                                     [
  //                                                                     index]['esc'],
  //                                                                 style: TextStyle(
  //                                                                     color: Colors
  //                                                                         .black87),
  //                                                                 textAlign:
  //                                                                     TextAlign
  //                                                                         .end,
  //                                                               ),
  //                                                             ),
  //                                                             SizedBox(
  //                                                               width: 10,
  //                                                             ),
  //                                                             Icon(
  //                                                               Icons.history,
  //                                                               color:
  //                                                                   Colors.blue,
  //                                                               size: 30,
  //                                                             ),

  //                                                             // Icon(
  //                                                             //   Icons.check_circle,
  //                                                             //   color: Colors.green,
  //                                                             // ),
  //                                                           ],
  //                                                         ),
  //                                                       ],
  //                                                     ),
  //                                                   ),
  //                                                 if (snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['accepted'] ==
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                             [index]['esc'] !=
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['assignTask'] ==
  //                                                         '')
  //                                                   SizedBox(
  //                                                     height: 10,
  //                                                   ),
  //                                               ],
  //                                             )
  //                                           : Column(
  //                                               //buble chat yg tampil jika ada pesan dari user lain..................................
  //                                               crossAxisAlignment:
  //                                                   CrossAxisAlignment.start,
  //                                               children: [
  //                                                 if (snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['accepted'] ==
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                             [index]['esc'] ==
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['assignTask'] ==
  //                                                         '')
  //                                                   Row(
  //                                                     mainAxisAlignment:
  //                                                         MainAxisAlignment
  //                                                             .spaceBetween,
  //                                                     children: [
  //                                                       Expanded(
  //                                                         child: Container(
  //                                                           alignment: Alignment
  //                                                               .centerLeft,
  //                                                           child: Padding(
  //                                                             padding:
  //                                                                 const EdgeInsets
  //                                                                         .only(
  //                                                                     right:
  //                                                                         30),
  //                                                             child: Container(
  //                                                               decoration:
  //                                                                   BoxDecoration(
  //                                                                 borderRadius:
  //                                                                     BorderRadius
  //                                                                         .circular(
  //                                                                             16),
  //                                                                 color: container[index %
  //                                                                     container
  //                                                                         .length],
  //                                                               ),
  //                                                               child: Padding(
  //                                                                 padding:
  //                                                                     const EdgeInsets
  //                                                                             .all(
  //                                                                         10.0),
  //                                                                 child: Column(
  //                                                                   crossAxisAlignment:
  //                                                                       CrossAxisAlignment
  //                                                                           .end,
  //                                                                   children: [
  //                                                                     Column(
  //                                                                       crossAxisAlignment:
  //                                                                           CrossAxisAlignment.start,
  //                                                                       children: [
  //                                                                         Text(
  //                                                                           snapshot.data!['comment'][index]['sender'],
  //                                                                           style:
  //                                                                               TextStyle(fontWeight: FontWeight.bold, color: msgSender[index % msgSender.length]),
  //                                                                         ),
  //                                                                         SizedBox(
  //                                                                           height:
  //                                                                               3,
  //                                                                         ),
  //                                                                         if (snapshot.data!['comment'][index]['commentBody'] !=
  //                                                                             '')
  //                                                                           SizedBox(
  //                                                                             height: 3,
  //                                                                           ),
  //                                                                         if (snapshot.data!['comment'][index]['commentBody'] !=
  //                                                                             '')
  //                                                                           Text(
  //                                                                             snapshot.data!['comment'][index]['commentBody'],
  //                                                                             style: TextStyle(color: Colors.black87),
  //                                                                           ),
  //                                                                         if (snapshot.data!['comment'][index]['description'] !=
  //                                                                             commentList[0])
  //                                                                           if (snapshot.data!['comment'][index]['description'] != '')
  //                                                                             Text(
  //                                                                               snapshot.data!['comment'][index]['description'],
  //                                                                               style: TextStyle(color: Colors.black87),
  //                                                                             ),
  //                                                                         if (snapshot.data!['comment'][index]['imageComment'] !=
  //                                                                             '')
  //                                                                           SizedBox(
  //                                                                             height: 5,
  //                                                                           ),
  //                                                                         if (snapshot.data!['comment'][index]['imageComment'] !=
  //                                                                             '')
  //                                                                           GestureDetector(
  //                                                                             onTap: () {
  //                                                                               Navigator.push(context, MaterialPageRoute(builder: (context) {
  //                                                                                 final listImage = commentList.where((element) => element['imageComment'] != '').toList();
  //                                                                                 return PageView.builder(
  //                                                                                   pageSnapping: true,
  //                                                                                   scrollDirection: Axis.horizontal,
  //                                                                                   itemCount: listImage.length,
  //                                                                                   itemBuilder: (context, index) {
  //                                                                                     var imageItem = listImage[index];
  //                                                                                     return ImageRoom(
  //                                                                                       image: imageItem['imageComment'],
  //                                                                                     );
  //                                                                                   },
  //                                                                                 );
  //                                                                               }));
  //                                                                             },
  //                                                                             child: Container(
  //                                                                               height: 80,
  //                                                                               width: 80,
  //                                                                               child: Hero(
  //                                                                                 tag: "imageHero",
  //                                                                                 child: Image.network(
  //                                                                                   snapshot.data!['comment'][index]['imageComment'],
  //                                                                                   width: 170,
  //                                                                                   fit: BoxFit.cover,
  //                                                                                 ),
  //                                                                               ),
  //                                                                             ),
  //                                                                           )
  //                                                                       ],
  //                                                                     ),
  //                                                                   ],
  //                                                                 ),
  //                                                               ),
  //                                                             ),
  //                                                           ),
  //                                                         ),
  //                                                       ),
  //                                                       Container(
  //                                                         width: 40,
  //                                                         child: Text(
  //                                                           snapshot.data![
  //                                                                   'comment']
  //                                                               [index]['time'],
  //                                                           style: TextStyle(
  //                                                               fontSize: 10,
  //                                                               color:
  //                                                                   Colors.grey,
  //                                                               height: 1.5),
  //                                                         ),
  //                                                       ),
  //                                                     ],
  //                                                   ),
  //                                                 //widget pesan yg ditampilkan ketika status diterima ......................................
  //                                                 if (snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['accepted'] !=
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                             [index]['esc'] ==
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['assignTask'] ==
  //                                                         '')
  //                                                   SizedBox(
  //                                                     height: 10,
  //                                                   ),
  //                                                 if (snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['accepted'] !=
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                             [index]['esc'] ==
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['assignTask'] ==
  //                                                         '')
  //                                                   Container(
  //                                                     width: double.infinity,
  //                                                     child: Row(
  //                                                       mainAxisAlignment:
  //                                                           MainAxisAlignment
  //                                                               .spaceBetween,
  //                                                       children: [
  //                                                         Row(
  //                                                           children: [
  //                                                             Icon(
  //                                                               Icons
  //                                                                   .check_circle,
  //                                                               color: Colors
  //                                                                   .green,
  //                                                               size: 35,
  //                                                             ),
  //                                                             SizedBox(
  //                                                               width: 10,
  //                                                             ),
  //                                                             Container(
  //                                                               width: 250,
  //                                                               child: Text(
  //                                                                 snapshot.data![
  //                                                                             'comment']
  //                                                                         [
  //                                                                         index]
  //                                                                     [
  //                                                                     'accepted'],
  //                                                                 style: TextStyle(
  //                                                                     color: Colors
  //                                                                         .black87),
  //                                                                 textAlign:
  //                                                                     TextAlign
  //                                                                         .start,
  //                                                               ),
  //                                                             ),
  //                                                           ],
  //                                                         ),
  //                                                         Container(
  //                                                           width: 40,
  //                                                           child: Text(
  //                                                             snapshot.data![
  //                                                                     'comment']
  //                                                                 [
  //                                                                 index]['time'],
  //                                                             style: TextStyle(
  //                                                                 fontSize: 10,
  //                                                                 color: Colors
  //                                                                     .grey,
  //                                                                 height: 1.5),
  //                                                           ),
  //                                                         ),
  //                                                       ],
  //                                                     ),
  //                                                   ),
  //                                                 if (snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['accepted'] !=
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                             [index]['esc'] ==
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['assignTask'] ==
  //                                                         '')
  //                                                   SizedBox(
  //                                                     height: 10,
  //                                                   ),

  //                                                 //widget pesan yg ditampilkan ketika status esc ......................................
  //                                                 if (snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['accepted'] ==
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                             [index]['esc'] !=
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['assignTask'] ==
  //                                                         '')
  //                                                   SizedBox(
  //                                                     height: 10,
  //                                                   ),
  //                                                 if (snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['accepted'] ==
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                             [index]['esc'] !=
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['assignTask'] ==
  //                                                         '')
  //                                                   Container(
  //                                                     width: double.infinity,
  //                                                     child: Row(
  //                                                       mainAxisAlignment:
  //                                                           MainAxisAlignment
  //                                                               .spaceBetween,
  //                                                       children: [
  //                                                         Row(
  //                                                           children: [
  //                                                             Icon(
  //                                                               Icons.schedule,
  //                                                               color: Colors
  //                                                                   .orange,
  //                                                               size: 30,
  //                                                             ),
  //                                                             SizedBox(
  //                                                               width: 10,
  //                                                             ),
  //                                                             Container(
  //                                                               alignment: Alignment
  //                                                                   .centerLeft,
  //                                                               width: 250,
  //                                                               child: Text(
  //                                                                 snapshot.data![
  //                                                                         'comment']
  //                                                                     [
  //                                                                     index]['esc'],
  //                                                                 style: TextStyle(
  //                                                                     color: Colors
  //                                                                         .black87),
  //                                                                 textAlign:
  //                                                                     TextAlign
  //                                                                         .end,
  //                                                               ),
  //                                                             ),

  //                                                             // Icon(
  //                                                             //   Icons.check_circle,
  //                                                             //   color: Colors.green,
  //                                                             // ),
  //                                                           ],
  //                                                         ),
  //                                                         Container(
  //                                                           width: 40,
  //                                                           child: Text(
  //                                                             snapshot.data![
  //                                                                     'comment']
  //                                                                 [
  //                                                                 index]['time'],
  //                                                             style: TextStyle(
  //                                                                 fontSize: 10,
  //                                                                 color: Colors
  //                                                                     .grey,
  //                                                                 height: 1.5),
  //                                                           ),
  //                                                         ),
  //                                                       ],
  //                                                     ),
  //                                                   ),
  //                                                 if (snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['accepted'] ==
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                             [index]['esc'] !=
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['assignTask'] ==
  //                                                         '')
  //                                                   SizedBox(
  //                                                     height: 10,
  //                                                   ),
  //                                                 // widget yg ditampilkan ketika kita assign request ke user lain.......................
  //                                                 if (snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['accepted'] ==
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                             [index]['esc'] ==
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['assignTask'] !=
  //                                                         '')
  //                                                   SizedBox(
  //                                                     height: 10,
  //                                                   ),
  //                                                 if (snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['accepted'] ==
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                             [index]['esc'] ==
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['assignTask'] !=
  //                                                         '')
  //                                                   Container(
  //                                                     width: double.infinity,
  //                                                     child: Row(
  //                                                       mainAxisAlignment:
  //                                                           MainAxisAlignment
  //                                                               .spaceBetween,
  //                                                       children: [
  //                                                         Row(
  //                                                           children: [
  //                                                             Icon(
  //                                                               Icons
  //                                                                   .person_pin,
  //                                                               color:
  //                                                                   Colors.blue,
  //                                                               size: 40,
  //                                                             ),
  //                                                             SizedBox(
  //                                                               width: 10,
  //                                                             ),
  //                                                             Container(
  //                                                               width: 250,
  //                                                               child: Text(
  //                                                                 snapshot.data![
  //                                                                             'comment']
  //                                                                         [
  //                                                                         index]
  //                                                                     [
  //                                                                     'assignTask'],
  //                                                                 style: TextStyle(
  //                                                                     color: Colors
  //                                                                         .black87,
  //                                                                     height:
  //                                                                         1.7),
  //                                                                 textAlign:
  //                                                                     TextAlign
  //                                                                         .start,
  //                                                               ),
  //                                                             ),

  //                                                             // Icon(
  //                                                             //   Icons.check_circle,
  //                                                             //   color: Colors.green,
  //                                                             // ),
  //                                                           ],
  //                                                         ),
  //                                                         Container(
  //                                                           width: 40,
  //                                                           child: Text(
  //                                                             snapshot.data![
  //                                                                     'comment']
  //                                                                 [
  //                                                                 index]['time'],
  //                                                             style: TextStyle(
  //                                                                 fontSize: 10,
  //                                                                 color: Colors
  //                                                                     .grey,
  //                                                                 height: 1.5),
  //                                                           ),
  //                                                         ),
  //                                                       ],
  //                                                     ),
  //                                                   ),
  //                                                 if (snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['accepted'] ==
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                             [index]['esc'] ==
  //                                                         '' &&
  //                                                     snapshot.data!['comment']
  //                                                                 [index]
  //                                                             ['assignTask'] !=
  //                                                         '')
  //                                                   SizedBox(
  //                                                     height: 10,
  //                                                   ),
  //                                               ],
  //                                             )),
  //                             ],
  //                           ));
  //                 }
  //                 return SizedBox();
  //               },
  //             ),
  //           ),
  //         ),
  //         Obx(() {
  //           return AnimatedSwitcher(
  //               duration: Duration(microseconds: 250),
  //               child: cAccepted.data == "Close"
  //                   ? Padding(
  //                       padding: const EdgeInsets.only(bottom: 50),
  //                       child: Container(
  //                         height: 30,
  //                         child: ElevatedButton(
  //                             style: ElevatedButton.styleFrom(
  //                                 shape: RoundedRectangleBorder(
  //                                     borderRadius: BorderRadius.circular(16))),
  //                             onPressed: () {
  //                               FirebaseFirestore.instance
  //                                   .collection('Hotel List')
  //                                   .doc(widget.hotelid)
  //                                   .collection('Others')
  //                                   .doc(widget.taskId)
  //                                   .update({
  //                                 "status": "Reopen",
  //                                 "receiver": cUser.data.name,
  //                                 "comment": FieldValue.arrayUnion([
  //                                   {
  //                                     'commentBody': "has reopen this request",
  //                                     'sender': cUser.data.name,
  //                                     'description': "",
  //                                     'senderemail': auth.currentUser!.email,
  //                                     'imageComment': '',
  //                                     'time': DateFormat.yMMMMd()
  //                                         .add_Hm()
  //                                         .format(DateTime.now())
  //                                         .toString(),
  //                                   }
  //                                 ])
  //                               });
  //                               cAccepted.setData("Reopen");
  //                               cAccepted.setSender(cUser.data.name!);
  //                               scrollController.jumpTo(
  //                                   scrollController.position.maxScrollExtent);
  //                               controller.clear();
  //                             },
  //                             child: Container(
  //                                 alignment: Alignment.center,
  //                                 height: 25,
  //                                 width: 70,
  //                                 child: Text("Reopen"))),
  //                       ),
  //                     )
  //                   : Keyboard2(
  //                       dept: widget.sendTo,
  //                       hotel: widget.hotelid,
  //                       scroll: scrollController,
  //                       taskId: widget.taskId,
  //                       from: widget.fromWhere,
  //                       status: widget.statusTask,
  //                       receiver: cAccepted.sender,
  //                       emailSender: widget.emailSender,
  //                       location: widget.location,
  //                       title: widget.tilteTask,
  //                       sendTo: widget.sendTo));
  //         })

  //         // Keyboard(
  //         //   taskId: widget.taskId,
  //         //   scroll: scrollController,
  //         //   dept: widget.sendTo,
  //         //   hotel: widget.hotelid,
  //         // ),
  //       ],
  //     )),
  //   );
  // }
}
