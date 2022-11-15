import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/dasboard/widget/animated/status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:post/service/theme.dart';

import 'pop_up_menu.dart';

class ChatRoomAppbar extends StatelessWidget {
  final String assignTo;
  final String imageProfileSender;
  final String sender;
  final String positionSender;
  final String status;
  final String receiver;
  final String title;
  final String lokasi;
  // final String image;
  final String schedule;
  final List<dynamic> assigned;
  const ChatRoomAppbar(
      {super.key,
      required this.imageProfileSender,
      required this.sender,
      required this.positionSender,
      required this.status,
      required this.receiver,
      required this.title,
      required this.lokasi,
      // required this.image,
      required this.schedule,
      required this.assigned,
      required this.assignTo});

  @override
  Widget build(BuildContext context) {
    final applications = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(top: Get.height * 0.04),
      height: Get.height * 0.2,
      child: Column(
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
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    foregroundImage: NetworkImage(imageProfileSender != ''
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
                        sender,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54),
                      ),
                      SizedBox(
                        height: Get.height * 0.005,
                      ),
                      Text(
                        positionSender,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                  Spacer(),
                  SizedBox(
                      height: Get.height * 0.04,
                      child: StatusWidget(status: status, isFading: false)),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    radius: 20,
                    onTap: () => showPopUpMenu(context),
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.black54,
                    ),
                  )
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                          '${applications!.title}: $title',
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
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      receiver != ''
                          ? Container(
                              width: Get.width * 0.40,
                              child: Text(
                                (status == "Assigned") 
                                    ? "${applications.to} $assignTo"
                                    : (receiver == '')
                                        ? ""
                                        : "${applications.by} $receiver",
                                style:
                                    TextStyle(color: secondary, fontSize: 14),
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.end,
                              ),
                            )
                          : SizedBox(),
                      SizedBox(
                        height: Get.height * 0.005,
                      ),
                      schedule != ''
                          ? Container(
                              width: Get.width * 0.40,
                              child: Text(
                                schedule,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 14),
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.end,
                              ),
                            )
                          : SizedBox(),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
