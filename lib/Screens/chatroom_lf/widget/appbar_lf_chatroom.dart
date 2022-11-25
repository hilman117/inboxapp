import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/chatroom/chatroom_controller.dart';
import 'package:post/Screens/dasboard/widget/animated/status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:post/Screens/dasboard/widget/card.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';

class AppBarLfChatRoom extends StatelessWidget {
  final String imageProfileSender;
  final String positionSender;
  final String lokasi;
  final String timeCreated;
  final String image;
  final String founder;
  final String status;
  final String nameItem;
  final String receiver;
  const AppBarLfChatRoom(
      {super.key,
      required this.imageProfileSender,
      required this.positionSender,
      required this.lokasi,
      // required this.image,
      required this.timeCreated,
      required this.image,
      required this.founder,
      required this.nameItem,
      required this.status,
      required this.receiver});

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
                      founder == cUser.data.name
                          ? Container(
                              height: Get.height * 0.04,
                              width: Get.width * 0.1,
                              child: Icon(
                                Icons.not_listed_location,
                                color: mainColor,
                                size: Get.width * 0.09,
                              ))
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
                            founder == cUser.data.name
                                ? "You reported this"
                                : founder,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black54),
                          ),
                          SizedBox(
                            height: Get.height * 0.005,
                          ),
                          Text(
                            founder == cUser.data.name
                                ? timeCreated
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
                          child: StatusWidget(status: status, isFading: false)),
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
                              '${applications!.title}: $nameItem',
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
                            height: founder == cUser.data.name
                                ? 00
                                : Get.height * 0.005,
                          ),
                          founder == cUser.data.name
                              ? SizedBox()
                              : Container(
                                  width: Get.width * 0.5,
                                  child: Text(
                                    'Created : $timeCreated',
                                    style: TextStyle(
                                        color: secondary, fontSize: 14),
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                              height: founder == cUser.data.name
                                  ? Get.height * 0.002
                                  : 0.0),
                          (status == 'Accepted' || status == 'Close')
                              ? Container(
                                  width: Get.width * 0.40,
                                  child: Text(
                                    "${applications.by} $receiver",
                                    style: TextStyle(
                                        color: secondary, fontSize: 14),
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.end,
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(
                            height: Get.height * 0.005,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
