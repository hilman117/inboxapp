import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/dasboard/widget/timer.dart';
import '../../../controller/c_user.dart';
import '../../../models/tasks.dart';
import '../../chatroom/chatroom.dart';
import '../../chatroom/widget/imageRoom.dart';
import 'animated/animated_receiver.dart';
import 'animated/status.dart';

Color themeColor = const Color(0xffF8CCA5);
Color cardColor = const Color(0xff475D5B);
final cUser = Get.put(CUser());
final taskmodel = Get.put(TaskModel());
double height = Get.height;
double width = Get.width;
// final cAccepted = Get.put(CAccepted());

Widget listdata(
  BuildContext context,
  Map<String, dynamic> data,
  TaskModel taskModel,
  Color? animationColor,
) {
  int runnningTime = DateTime.now().difference(taskModel.time!).inMinutes;
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
          color: data['status'] == "New" ? animationColor : Colors.white,
        ),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Get.to(
                  () => Chatroom(
                        descriptionTask: taskModel.description!,
                        hotelid: cUser.data.hotelid!,
                        location: taskModel.location!,
                        nameSender: taskModel.sender!,
                        penerimaTask: taskModel.receiver!,
                        schedule: taskModel.setDate!,
                        sendTo: taskModel.sendTo!,
                        statusTask: taskModel.status!,
                        taskId: taskModel.id!,
                        tilteTask: taskModel.title!,
                        time: taskModel.time!,
                        fromWhere: taskModel.from!,
                        emailSender: data['emailSender'],
                        jarakWaktu: runnningTime,
                        assign: data['assigned'],
                        imageProfileSender: data['profileImageSender'],
                        positionSender: data['positionSender'],
                      ),
                  transition: Transition.rightToLeft);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "images/${taskModel.sendTo}.png",
                                fit: BoxFit.cover,
                                width: width * 0.060,
                              ),
                              SizedBox(
                                width: width * 0.016,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                width: width * 0.6,
                                child: Text(
                                  taskModel.title!,
                                  style: TextStyle(fontSize: 16),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              Spacer(),
                              StatusWidget(
                                  status: runnningTime >= 5 &&
                                          data['status'] == "New"
                                      ? "ESC"
                                      : taskModel.status!,
                                  isFading: data["isFading"])
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: height * 0.004),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          // height: 17,
                          child: Row(
                            children: [
                              if (taskModel.image != '')
                                InkWell(
                                  onTap: () => Get.to(() => ImageRoom(
                                        image: taskmodel.image!,
                                        id: '',
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Icon(Icons.attach_file,
                                        color: Color(0xff007dff), size: 16),
                                  ),
                                ),
                              if (taskModel.image != '')
                                SizedBox(
                                  width: width * 0.035,
                                ),
                              if (taskModel.image == '')
                                SizedBox(
                                  width: width * 0.075,
                                ),
                              Container(
                                width: width * 0.40,
                                child: Text(
                                  taskModel.location!,
                                  style: TextStyle(fontSize: 15),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              Spacer(),
                              runnningTime >= 5 && data['status'] == "New"
                                  ? Container(
                                      alignment: Alignment.centerRight,
                                      width: width * 0.40,
                                      child: Container(),
                                    )
                                  : AnimatedReceiver(
                                      receiver: data['receiver'],
                                      status: data['status'],
                                      assigned: data['assigned'],
                                      isFading: data['isFading'],
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
                  if (taskModel.setDate! != '' || taskModel.setTime! != '')
                    SizedBox(
                      height: 3,
                    ),
                  if (taskModel.setDate! != '' || taskModel.setTime! != '')
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            // height: 17,
                            child: Row(
                              children: [
                                if (taskModel.setDate! != '' ||
                                    taskModel.setTime! != '')
                                  Icon(Icons.alarm,
                                      color: data['status'] == 'Close'
                                          ? Colors.grey
                                          : Colors.red,
                                      size: 15),
                                SizedBox(width: 10),
                                Container(
                                  width: width * 0.60,
                                  child: Text(
                                    "Due ${taskModel.setDate} ${taskModel.setTime}",
                                    // taskModel.setDate!,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        color: data['status'] == 'Close'
                                            ? Colors.grey
                                            : Colors.red,
                                        fontSize: 13),
                                  ),
                                ),
                                Spacer(),
                                if (taskModel.setDate! != '' ||
                                    taskModel.setTime! != '')
                                  Container(
                                    width: width * 0.23,
                                    child: Text(
                                      remainingDateTime(
                                          context, taskModel.time!),
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
                    height: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            // height: 17,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: width * 0.077,
                                ),
                                Container(
                                  width: width * 0.60,
                                  child: Text(
                                    taskModel.sender!,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        fontSize: 13, color: Color(0xffBDBDBD)),
                                  ),
                                ),
                                Spacer(),
                                if (taskModel.setDate! == '' ||
                                    taskModel.setTime! == '')
                                  Container(
                                    width: width * 0.23,
                                    child: Text(
                                      remainingDateTime(
                                          context, taskModel.time!),
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
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  if (taskModel.description! != '')
                    Row(
                      children: [
                        Container(height: 2, width: width * 0.077),
                        Container(
                          width: width * 0.60,
                          child: Text(
                            taskModel.description!,
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
