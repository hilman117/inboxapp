import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:post/Screens/chatroom/chatroom_controller.dart';
import 'package:post/Screens/chatroom/widget/pop_up_menu/pop_up_menu_provider.dart';
import 'package:post/Screens/create/create_request_controller.dart';
import 'package:post/Screens/dasboard/widget/animated/status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:post/Screens/dasboard/widget/card.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';

import 'pop_up_menu/pop_up_menu.dart';

class ChatRoomAppbar extends StatelessWidget {
  final String imageProfileSender;
  final String emailSender;
  final String sender;
  final String positionSender;
  final String lokasi;
  final String sendTo;
  final String taskId;
  final String oldDate;
  final String oldTime;
  final DateTime timeCreated;
  // final String image;
  final List<dynamic> assigned;
  const ChatRoomAppbar({
    super.key,
    required this.imageProfileSender,
    required this.sender,
    required this.positionSender,
    required this.lokasi,
    // required this.image,
    required this.assigned,
    required this.sendTo,
    required this.timeCreated,
    required this.taskId,
    required this.emailSender,
    required this.oldDate,
    required this.oldTime,
  });

  @override
  Widget build(BuildContext context) {
    final applications = AppLocalizations.of(context);
    return Container(
        margin: EdgeInsets.only(top: Get.height * 0.04),
        height: Get.height * 0.2,
        child: Consumer<ChatRoomController>(
          builder: (context, value, child) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Get.height * 0.054,
                // color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      sender == cUser.data.name
                          ? Container(
                              height: Get.height * 0.04,
                              width: Get.width * 0.1,
                              child: assigned.isEmpty
                                  ? Icon(
                                      Icons.not_listed_location_rounded,
                                      size: width * 0.09,
                                      color: mainColor,
                                    )
                                  : Image.asset('images/$sendTo.png'))
                          : CircleAvatar(
                              backgroundColor: Colors.grey,
                              foregroundImage: NetworkImage(imageProfileSender !=
                                      ''
                                  ? imageProfileSender
                                  : 'https://scontent.fcgk27-1.fna.fbcdn.net/v/t39.30808-6/314984197_5217827161655012_8963512146921511629_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=730e14&_nc_eui2=AeF937McIYSdTVi3_HoAAHOf9YToegKuJSf1hOh6Aq4lJ-TRMK8gevR9UQqjUG6tSX_gzDf107wjEC3d0441twh0&_nc_ohc=OJUCMD0cz8sAX929JAg&_nc_ht=scontent.fcgk27-1.fna&oh=00_AfAql1vtroWjeyiDoxvjyCe07Ajttnv48E7Z1OwCJyK8wQ&oe=636F4993'),
                              backgroundImage: AssetImage('images/nophoto.png'),
                            ),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (sendTo.isEmpty)
                                ? "You created this report"
                                : (sender == cUser.data.name)
                                    ? "to $sendTo"
                                    : sender,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black54),
                          ),
                          SizedBox(
                            height: Get.height * 0.005,
                          ),
                          Text(
                            sender == cUser.data.name
                                ? "${DateFormat('EEEE, MMM d, hh:mm').format(timeCreated)}"
                                : positionSender,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                      Spacer(),
                      SizedBox(
                          height: Get.height * 0.03,
                          child: StatusWidget(
                              status: value.status, isFading: false)),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                      Consumer<CreateRequestController>(
                          builder: (context, value, child) => InkWell(
                                borderRadius: BorderRadius.circular(50),
                                radius: 20,
                                onTap: () => showPopUpMenu(
                                    context,
                                    sendTo,
                                    taskId,
                                    emailSender,
                                    oldDate,
                                    oldTime,
                                    lokasi),
                                child: Icon(
                                  Icons.more_vert,
                                  color: Colors.black54,
                                ),
                              ))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Container(
                color: mainColor.withOpacity(0.2),
                width: Get.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: Get.width * 0.45,
                            child: Text(
                              '${applications!.title}: ${Provider.of<PopUpMenuProvider>(context).title}',
                              style: TextStyle(color: secondary, fontSize: 14),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.005,
                          ),
                          Container(
                            width: Get.width * 0.5,
                            child: Text(
                              '${applications.location}: $lokasi',
                              style: TextStyle(color: secondary, fontSize: 14),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          SizedBox(
                            height: sender == cUser.data.name
                                ? 00
                                : Get.height * 0.005,
                          ),
                          sender == cUser.data.name
                              ? SizedBox()
                              : Container(
                                  width: Get.width * 0.5,
                                  child: Text(
                                    'Created : ${DateFormat('EEEE, MMM d, hh:mm').format(timeCreated)}',
                                    style: TextStyle(
                                        color: secondary, fontSize: 14),
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                        ],
                      ),
                      Spacer(),
                      Consumer<CreateRequestController>(
                          builder: (context, val, child) => Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                      height: sender == cUser.data.name
                                          ? Get.height * 0.002
                                          : 0.0),
                                  (value.status == 'Accepted' ||
                                          value.status == 'Close')
                                      ? Container(
                                          width: Get.width * 0.40,
                                          child: Text(
                                            "${applications.by} ${value.receiver}",
                                            style: TextStyle(
                                                color: secondary, fontSize: 14),
                                            overflow: TextOverflow.clip,
                                            textAlign: TextAlign.end,
                                          ),
                                        )
                                      : (value.status == "Assigned" ||
                                              value.status == 'Close')
                                          ? Container(
                                              width: Get.width * 0.40,
                                              child: Text(
                                                "${applications.to} ${value.assignTo}",
                                                style: TextStyle(
                                                    color: secondary,
                                                    fontSize: 14),
                                                overflow: TextOverflow.clip,
                                                textAlign: TextAlign.end,
                                              ),
                                            )
                                          : SizedBox(),
                                  SizedBox(
                                    height: Get.height * 0.005,
                                  ),
                                  (val.datePicked != '' ||
                                          val.selectedTime != '')
                                      ? Container(
                                          width: Get.width * 0.40,
                                          child: Text(
                                            "${val.datePicked} ${val.selectedTime}",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 14),
                                            overflow: TextOverflow.clip,
                                            textAlign: TextAlign.end,
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
