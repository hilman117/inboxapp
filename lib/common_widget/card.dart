import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:post/Screens/homescreen/home_controller.dart';
import 'package:post/common_widget/status.dart';
import 'package:provider/provider.dart';
import '../controller/c_user.dart';
import '../models/tasks.dart';
import '../Screens/chatroom/chatroom_task.dart';
import '../Screens/chatroom/widget/imageRoom.dart';
import '../Screens/chatroom/widget/pop_up_menu/pop_up_menu_provider.dart';
import '../Screens/dasboard/widget/timer.dart';
import '../Screens/dasboard/widget/animated/animated_receiver.dart';

Color themeColor = const Color(0xffF8CCA5);
Color cardColor = const Color(0xff475D5B);
final cUser = Get.put(CUser());
final taskmodel = Get.put(TaskModel());
double height = Get.height;
double width = Get.width;
// final cAccepted = Get.put(CAccepted())

class CardList extends StatefulWidget {
  const CardList(
      {super.key,
      required this.data,
      required this.taskModel,
      required this.animationColor,
      required this.listImage,
      required this.list});

  final Map<String, dynamic> data;
  final List<QueryDocumentSnapshot<Object?>> list;
  final TaskModel taskModel;
  final Color? animationColor;
  final List listImage;

  @override
  State<CardList> createState() => _CardListState();
}
// StreamSubscription<ReceivedAction>? _actionStreamSubscription;
// void listen() async {
//   // You can choose to cancel any exiting subscriptions
//   // await _actionStreamSubscription?.cancel();

//   // assign the stream subscription

// }

class _CardListState extends State<CardList> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeController>(context, listen: false)
        .scheduleNotification(widget.list);
    // AwesomeNotifications().actionStream.listen((notif) {
    //   if (notif.channelKey == 'basic_channel' && Platform.isIOS) {
    //     AwesomeNotifications().getGlobalBadgeCounter().then(
    //         (value) => AwesomeNotifications().setGlobalBadgeCounter(value - 1));
    //   }
    //   Get.to(
    //       () => Chatroom(
    //             descriptionTask: widget.taskModel.description!,
    //             hotelid: cUser.data.hotelid!,
    //             location: widget.taskModel.location!,
    //             nameSender: widget.taskModel.sender!,
    //             penerimaTask: widget.taskModel.receiver!,
    //             schedule: widget.taskModel.setDate!,
    //             sendTo: widget.taskModel.sendTo!,
    //             statusTask: widget.taskModel.status!,
    //             taskId: widget.taskModel.id!,
    //             tilteTask: widget.taskModel.title!,
    //             time: widget.taskModel.time!,
    //             fromWhere: widget.taskModel.from!,
    //             emailSender: widget.data['emailSender'],
    //             jarakWaktu: 0,
    //             assign: widget.data['assigned'],
    //             imageProfileSender: widget.data['profileImageSender'],
    //             positionSender: widget.data['positionSender'],
    //           ),
    //       transition: Transition.rightToLeft);
    // });
  }

  @override
  Widget build(BuildContext context) {
    double padding = MediaQuery.of(context).padding.top;
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    double bodyHeight = fullHeight - padding;

    int runnningTime =
        DateTime.now().difference(widget.taskModel.time!).inMinutes;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  // blurRadius: ,
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 0.7,
                  offset: Offset(0, 0.5))
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
                Provider.of<PopUpMenuProvider>(context, listen: false)
                    .changeTitle(widget.taskModel.title!);
                Get.to(
                    () => ChatRoomTask(
                          descriptionTask: widget.taskModel.description!,
                          hotelid: cUser.data.hotelid!,
                          location: widget.taskModel.location!,
                          nameSender: widget.taskModel.sender!,
                          penerimaTask: widget.taskModel.receiver!,
                          setDate: widget.taskModel.setDate!,
                          sendTo: widget.taskModel.sendTo!,
                          statusTask: widget.taskModel.status!,
                          taskId: widget.taskModel.id!,
                          tilteTask: widget.taskModel.title!,
                          time: widget.taskModel.time!,
                          fromWhere: widget.taskModel.from!,
                          emailSender: widget.data['emailSender'],
                          jarakWaktu: runnningTime,
                          assign: widget.data['assigned'],
                          imageProfileSender: widget.data['profileImageSender'],
                          positionSender: widget.data['positionSender'],
                          setTime: widget.taskModel.setTime!,
                        ),
                    transition: Transition.rightToLeft);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "images/${widget.taskModel.sendTo}.png",
                                      fit: BoxFit.cover,
                                      width:
                                          MediaQuery.of(context).orientation ==
                                                  Orientation.landscape
                                              ? fullWidth * 0.030
                                              : fullWidth * 0.060,
                                    ),
                                    SizedBox(
                                      width: width * 0.016,
                                    ),
                                    Consumer<HomeController>(
                                      builder: (context, value, child) =>
                                          Container(
                                        alignment: Alignment.centerLeft,
                                        width: fullWidth * 0.6,
                                        child: Text(
                                          widget.taskModel.title!,
                                          style: TextStyle(fontSize: 16),
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).orientation ==
                                          Orientation.landscape
                                      ? fullWidth * 0.14
                                      : fullWidth * 0.19,
                                  height: MediaQuery.of(context).orientation ==
                                          Orientation.landscape
                                      ? bodyHeight * 0.06
                                      : bodyHeight * 0.033,
                                  child: StatusWidget(
                                    status: runnningTime >= 5 &&
                                            widget.data['status'] == "New"
                                        ? "ESC"
                                        : widget.taskModel.status!,
                                    isFading: widget.data["isFading"],
                                    height:
                                        MediaQuery.of(context).orientation ==
                                                Orientation.landscape
                                            ? 1
                                            : 1,
                                    fontSize: 13,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.004),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            // height: 17,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    widget.listImage.isNotEmpty
                                        ? InkWell(
                                            onTap: () => Get.to(() => ImageRoom(
                                                  image: widget.data['image'],
                                                  id: '',
                                                )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 2),
                                              child: Icon(Icons.attach_file,
                                                  color: Color(0xff007dff),
                                                  size: 16),
                                            ),
                                          )
                                        : SizedBox(),
                                    SizedBox(
                                      width: widget.listImage.isEmpty
                                          ? width * 0.075
                                          : width * 0.035,
                                    ),
                                    Container(
                                      width: width * 0.40,
                                      child: Text(
                                        widget.taskModel.location!,
                                        style: TextStyle(fontSize: 14),
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ],
                                ),
                                runnningTime >= 5 &&
                                        widget.data['status'] == "New"
                                    ? Container(
                                        alignment: Alignment.centerRight,
                                        width: width * 0.40,
                                        child: Container(),
                                      )
                                    : AnimatedReceiver(
                                        receiver: widget.data['receiver'],
                                        status: widget.data['status'],
                                        assigned: widget.data['assigned'],
                                        isFading: widget.data['isFading'],
                                      )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: widget.taskModel.setDate! != '' ||
                              widget.taskModel.setTime! != ''
                          ? 2
                          : height * 0.001,
                    ),
                    if (widget.taskModel.setDate! != '' ||
                        widget.taskModel.setTime! != '')
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              // height: 17,
                              child: Row(
                                children: [
                                  if (widget.taskModel.setDate! != '' ||
                                      widget.taskModel.setTime! != '')
                                    Icon(Icons.alarm,
                                        color: widget.data['status'] == 'Close'
                                            ? Colors.grey
                                            : Colors.red,
                                        size: 15),
                                  SizedBox(width: 13),
                                  Container(
                                    width: width * 0.60,
                                    child: Text(
                                      "Due ${DateFormat("EE d").format(DateTime.parse(widget.taskModel.setDate!))}, ${widget.taskModel.setTime}",
                                      // taskModel.setDate!,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color:
                                              widget.data['status'] == 'Close'
                                                  ? Colors.grey
                                                  : Colors.red,
                                          fontSize: 13),
                                    ),
                                  ),
                                  Spacer(),
                                  if (widget.taskModel.setDate! != '' ||
                                      widget.taskModel.setTime! != '')
                                    Container(
                                      width: width * 0.23,
                                      child: Text(
                                        remainingDateTime(
                                            context, widget.taskModel.time!),
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.blue),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              // height: 17,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.077,
                                      ),
                                      Container(
                                        width: width * 0.60,
                                        child: Text(
                                          widget.taskModel.sender!,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xffBDBDBD)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                    width: width * 0.23,
                                    child: widget.taskModel.setDate! == '' &&
                                            widget.taskModel.setTime! == ''
                                        ? Text(
                                            remainingDateTime(context,
                                                widget.taskModel.time!),
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.blue),
                                          )
                                        : SizedBox(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.005,
                    ),
                    if (widget.taskModel.description! != '')
                      Row(
                        children: [
                          Container(height: 2, width: width * 0.077),
                          Container(
                            width: width * 0.60,
                            child: Text(
                              widget.taskModel.description!,
                              style: TextStyle(
                                  fontSize: 13, color: Color(0xffBDBDBD)),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
