import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../service/theme.dart';
import '../../../dasboard/widget/card.dart';
import '../../../sign_up/signup.dart';
import '../../chatroom_controller.dart';
import '../keyboard.dart';
import '../left_buble/left_bubble.dart';
import '../right_bubble/right_bubble.dart';

// ignore: must_be_immutable
class StreamLfChat extends StatelessWidget {
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

  StreamLfChat(
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
    final provider = Provider.of<ChatRoomController>(context, listen: false);
    return SafeArea(
      child: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Hotel List')
                  .doc(cUser.data.hotelid)
                  .collection('lost and found')
                  .doc(taskId)
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
                              ? RightBubble(
                                  assignSender: snapshot.data!['comment'][index]
                                      ['assignTask'],
                                  assignTo: snapshot.data!['comment'][index]
                                      ['assignTo'],
                                  commentList: commentList,
                                  esc: snapshot.data!['comment'][index]['esc'],
                                  image: snapshot.data!['comment'][index]
                                      ['imageComment'],
                                  isAccepted: snapshot.data!['comment'][index]
                                      ['accepted'],
                                  message: snapshot.data!['comment'][index]
                                      ['commentBody'],
                                  senderMsgName: snapshot.data!['comment']
                                      [index]['sender'],
                                  time: snapshot.data!['comment'][index]
                                      ['time'],
                                  titleChanging: '',
                                  deleteSchedule: '',
                                  editLocation: '',
                                  hold: '',
                                  resume: '',
                                  setDate: '',
                                  setTime: '',
                                )
                              : LeftBubble(
                                  assignSender: snapshot.data!['comment'][index]
                                      ['assignTask'],
                                  assignTo: snapshot.data!['comment'][index]
                                      ['assignTo'],
                                  commentList: commentList,
                                  esc: snapshot.data!['comment'][index]['esc'],
                                  image: snapshot.data!['comment'][index]
                                      ['imageComment'],
                                  isAccepted: snapshot.data!['comment'][index]
                                      ['accepted'],
                                  message: snapshot.data!['comment'][index]
                                      ['commentBody'],
                                  senderMsgName: snapshot.data!['comment']
                                      [index]['sender'],
                                  time: snapshot.data!['comment'][index]
                                      ['time'],
                                  titleChanging: '',
                                  deleteSchedule: '',
                                  editLocation: '',
                                  hold: '',
                                  resume: '',
                                  setDate: '',
                                  setTime: '',
                                ),
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
                    value.status == "Claimed" || value.status == "Released"
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: keyboardChat(
                                context,
                                taskId,
                                location,
                                tilteTask,
                                scrollController,
                                fromWhere,
                                sendTo,
                                nameSender,
                                emailSender),
                          ),
                    value.imagesList.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Stack(
                              children: [
                                // Container(
                                //   alignment: Alignment.centerLeft,
                                //   height: height * 0.06,
                                //   width: widht * 0.6,
                                //   child: Image.file(
                                //     value.images!,
                                //     fit: BoxFit.cover,
                                //   ),
                                // ),
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
    );
  }
}
