import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/dasboard/widget/animated/status.dart';
import 'package:post/service/theme.dart';

Widget chatroomAppbar(
        String imageProfileSender,
        String sender,
        String positionSender,
        String status,
        String receiver,
        String title,
        String lokasi,
        String image,
        List<dynamic> assigned) =>
    Container(
      margin: EdgeInsets.only(top: Get.height * 0.04),
      height: Get.height * 0.2,
      child: Column(
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
                  Icon(
                    Icons.more_vert,
                    color: Colors.black54,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Container(
            height: Get.height * 0.065,
            color: mainColor,
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(
                        height: Get.height * 0.005,
                      ),
                      Text(
                        lokasi,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      receiver != ''
                          ? Text(
                              'by $receiver',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                              textAlign: TextAlign.end,
                            )
                          : SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
