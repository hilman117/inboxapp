import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../dasboard/widget/card.dart';
import '../../../sign_up/signup.dart';
import '../../chatroom_controller.dart';
import '../assign/assign_dialog.dart';
import '../button.dart';
import '../close_dialog.dart';
import '../keyboard.dart';
import '../left_buble/left_bubble.dart';
import '../list_images_comment.dart';
import '../right_bubble/right_bubble.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final app = AppLocalizations.of(context);
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
                  .collection('tasks')
                  .doc(taskId)
                  .snapshots(includeMetadataChanges: true),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  var commentList = (snapshot.data!.data()
                      as Map<String, dynamic>)['comment'] as List;
                  commentList.sort((a, b) => b['time'].compareTo(a['time']));
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    reverse: false,
                    padding: EdgeInsets.all(0),
                    controller: scrollController,
                    itemCount: commentList.length,
                    itemBuilder: (context, index) {
                      // print(imagestotal);
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
                                  titleChanging: snapshot.data!['comment']
                                      [index]['titleChange'],
                                  setTime: snapshot.data!['comment'][index]
                                      ['setTime'],
                                  deleteSchedule: snapshot.data!['comment']
                                      [index]['scheduleDelete'],
                                  editLocation: snapshot.data!['comment'][index]
                                      ['newlocation'],
                                  hold: snapshot.data!['comment'][index]
                                      ['hold'],
                                  resume: snapshot.data!['comment'][index]
                                      ['resume'],
                                  setDate: snapshot.data!['comment'][index]
                                      ['setDate'],
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
                                  titleChanging: snapshot.data!['comment']
                                      [index]['titleChange'],
                                  setTime: snapshot.data!['comment'][index]
                                      ['setTime'],
                                  deleteSchedule: snapshot.data!['comment']
                                      [index]['scheduleDelete'],
                                  editLocation: snapshot.data!['comment'][index]
                                      ['newlocation'],
                                  hold: snapshot.data!['comment'][index]
                                      ['hold'],
                                  resume: snapshot.data!['comment'][index]
                                      ['resume'],
                                  setDate: snapshot.data!['comment'][index]
                                      ['setDate'],
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
                                      taskId,
                                      location,
                                      tilteTask,
                                      scrollController,
                                      emailSender,
                                      sendTo);
                                }, statusTask),
                          value.status == "Close"
                              ? button(app!.reopen, () {
                                  provider.reopen(context, taskId, location,
                                      tilteTask, scrollController, sendTo);
                                }, statusTask)
                              : button(app!.assign, () async {
                                  assign(context, taskId, emailSender, location,
                                      tilteTask, scrollController);
                                  await provider.getDeptartementAndNames();
                                }, statusTask),
                          value.status == "Close"
                              ? SizedBox()
                              : button(app.accept, () {
                                  value.receiver == cUser.data.name
                                      ? Fluttertoast.showToast(
                                          textColor: Colors.black,
                                          backgroundColor: Colors.white,
                                          msg: "You have received this request")
                                      : provider.accept(
                                          context,
                                          taskId,
                                          emailSender,
                                          location,
                                          tilteTask,
                                          scrollController,
                                          sendTo);
                                }, statusTask),
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
                                taskId,
                                location,
                                tilteTask,
                                scrollController,
                                fromWhere,
                                sendTo,
                                "",
                                ""),
                          ),
                    value.imagesList.isNotEmpty
                        ? ListImagesComment()
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
