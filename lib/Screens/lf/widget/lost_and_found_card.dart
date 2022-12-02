import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/c_user.dart';
import '../../../models/tasks.dart';
import '../../../service/theme.dart';
import '../../chatroom/chatroom.dart';
import '../../dasboard/widget/animated/animated_receiver.dart';
import '../../dasboard/widget/animated/status.dart';

Color themeColor = const Color(0xffF8CCA5);
Color cardColor = const Color(0xff475D5B);
final cUser = Get.put(CUser());
final taskmodel = Get.put(TaskModel());
double height = Get.height;
double width = Get.width;
// final cAccepted = Get.put(CAccepted())

class LoasNfoundCard extends StatefulWidget {
  const LoasNfoundCard(
      {super.key, required this.data, required this.animationColor});

  final Map<String, dynamic> data;
  final Color? animationColor;

  @override
  State<LoasNfoundCard> createState() => _LoasNfoundCardState();
}
// StreamSubscription<ReceivedAction>? _actionStreamSubscription;
// void listen() async {
//   // You can choose to cancel any exiting subscriptions
//   // await _actionStreamSubscription?.cancel();

//   // assign the stream subscription

// }

class _LoasNfoundCardState extends State<LoasNfoundCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // int runnningTime =
    //     DateTime.now().difference(widget.lfModel.).inMinutes;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0.7,
                    offset: Offset(0.05, 0.05))
              ],
              borderRadius: BorderRadius.circular(16),
              color: widget.data['status'] == "New"
                  ? widget.animationColor
                  : Colors.white,
            ),
            child: Material(
              borderRadius: BorderRadius.circular(16),
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Get.to(
                      () => Chatroom(
                          taskId: widget.data["id"],
                          nameSender: widget.data["founder"],
                          tilteTask: widget.data["nameItem"],
                          descriptionTask: widget.data["description"],
                          statusTask: widget.data["status"],
                          penerimaTask: widget.data["receiveBy"],
                          location: widget.data["location"],
                          time: DateTime.now(),
                          hotelid: cUser.data.hotelid!,
                          sendTo: "",
                          schedule: "",
                          fromWhere: "",
                          emailSender: widget.data["emailSender"],
                          jarakWaktu: 0,
                          assign: [],
                          imageProfileSender: widget.data["profileImageSender"],
                          positionSender: widget.data["positionSender"]),
                      transition: Transition.rightToLeft);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.not_listed_location,
                              size: Get.width * 0.05,
                              color: mainColor,
                            ),
                            SizedBox(
                              width: Get.width * 0.015,
                            ),
                            Expanded(
                              child: Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      width: width * 0.6,
                                      child: Text(
                                        widget.data["nameItem"],
                                        style: TextStyle(fontSize: 16),
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                    Spacer(),
                                    StatusWidget(
                                        status: widget.data["status"],
                                        isFading: false)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: height * 0.004),
                        Row(
                          children: [
                            Icon(
                              Icons.attach_file,
                              size: Get.width * 0.05,
                              color: Colors.grey.shade500,
                            ),
                            SizedBox(
                              width: Get.width * 0.015,
                            ),
                            Expanded(
                              child: Container(
                                // height: 17,
                                child: Row(
                                  children: [
                                    // SizedBox(
                                    //   width: width * 0.075,
                                    // ),
                                    Container(
                                      width: width * 0.40,
                                      child: Text(
                                        widget.data["location"],
                                        style: TextStyle(fontSize: 15),
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                    Spacer(),
                                    AnimatedReceiver(
                                      receiver: widget.data['receiver'],
                                      status: widget.data['status'],
                                      assigned: [],
                                      isFading: false,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.002,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: Get.width * 0.065,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Row(
                                children: [
                                  Container(
                                    // height: 17,
                                    child: Row(
                                      children: [
                                        // SizedBox(
                                        //   width: width * 0.077,
                                        // ),
                                        Container(
                                          width: width * 0.60,
                                          child: Text(
                                            widget.data["founder"],
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Color(0xffBDBDBD)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        if (widget.data["description"] != '')
                          Row(
                            children: [
                              SizedBox(
                                width: Get.width * 0.065,
                              ),
                              Container(
                                width: width * 0.60,
                                child: Text(
                                  widget.data["description"],
                                  style: TextStyle(
                                      fontSize: 13, color: Color(0xffBDBDBD)),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                      ]),
                ),
              ),
            )));
  }
}
