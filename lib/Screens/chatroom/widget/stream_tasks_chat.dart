// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_widget/card.dart';
import '../../sign_up/signup.dart';
import 'left_buble/left_bubble.dart';

import 'right_bubble/right_bubble.dart';

// ignore: must_be_immutable
class StreamTasksChat extends StatelessWidget {
  final scrollController = ScrollController();
  final String taskId;
  final List<dynamic> assignLIst;
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

  double widht = Get.width;
  double height = Get.height;

  StreamTasksChat(
      {super.key,
      required this.taskId,
      required this.assignLIst,
      required this.sendTo,
      required this.imageProfileSender,
      required this.positionSender,
      required this.emailSender,
      required this.location,
      required this.nameSender,
      required this.tilteTask,
      required this.descriptionTask,
      required this.statusTask,
      required this.penerimaTask,
      required this.hotelid,
      required this.time,
      required this.fromWhere,
      required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Hotel List')
                .doc(cUser.data.hotelid)
                .collection('tasks')
                .doc(taskId)
                .snapshots(includeMetadataChanges: true),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                var commentList = (snapshot.data!.data()
                    as Map<String, dynamic>)['comment'] as List;
                commentList.sort((a, b) => b['time'].compareTo(a['time']));
                return ScrollConfiguration(
                  behavior: ScrollBehavior(),
                  child: GlowingOverscrollIndicator(
                    axisDirection: AxisDirection.down,
                    color: Colors.white,
                    child: ListView.builder(
                      // physics: BouncingScrollPhysics(),
                      reverse: true,
                      padding: EdgeInsets.only(bottom: height * 0.02),
                      controller: scrollController,
                      itemCount: commentList.length,
                      itemBuilder: (context, index) {
                        // print(imagestotal);
                        return Column(
                          children: [
                            commentList[index]['senderemail'] ==
                                    auth.currentUser!.email
                                ? RightBubble(
                                    assignSender: commentList[index]
                                        ['assignTask'],
                                    assignTo: commentList[index]['assignTo'],
                                    commentList: commentList,
                                    esc: commentList[index]['esc'],
                                    image: commentList[index]['imageComment'],
                                    isAccepted: commentList[index]['accepted'],
                                    message: commentList[index]['commentBody'],
                                    senderMsgName: commentList[index]['sender'],
                                    time: commentList[index]['time'],
                                    titleChanging: commentList[index]
                                        ['titleChange'],
                                    setTime: commentList[index]['setTime'],
                                    deleteSchedule: commentList[index]
                                        ['scheduleDelete'],
                                    editLocation: commentList[index]
                                        ['newlocation'],
                                    hold: commentList[index]['hold'],
                                    resume: commentList[index]['resume'],
                                    setDate: commentList[index]['setDate'],
                                    description: commentList[index]
                                        ['description'],
                                  )
                                : LeftBubble(
                                    assignSender: commentList[index]
                                        ['assignTask'],
                                    assignTo: commentList[index]['assignTo'],
                                    commentList: commentList,
                                    esc: commentList[index]['esc'],
                                    image: commentList[index]['imageComment'],
                                    isAccepted: commentList[index]['accepted'],
                                    message: commentList[index]['commentBody'],
                                    senderMsgName: commentList[index]['sender'],
                                    time: commentList[index]['time'],
                                    titleChanging: commentList[index]
                                        ['titleChange'],
                                    setTime: commentList[index]['setTime'],
                                    deleteSchedule: commentList[index]
                                        ['scheduleDelete'],
                                    editLocation: commentList[index]
                                        ['newlocation'],
                                    hold: commentList[index]['hold'],
                                    resume: commentList[index]['resume'],
                                    setDate: commentList[index]['setDate'],
                                    description: commentList[index]
                                        ['description'],
                                  ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ));
  }
}
