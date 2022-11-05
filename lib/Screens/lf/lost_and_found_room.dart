import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/dasboard/widget/card.dart';
import 'package:post/Screens/lf/lf_controller.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';

import 'widget/descriptions_item.dart';
import 'widget/name_item_box.dart';
import 'widget/status_box.dart';

class LostAndFoundRoom extends StatelessWidget {
  final String image;
  final String itemName;
  final String founder;
  final String location;
  final String time;
  final String status;
  final String receiver;
  final String description;
  final String statusReleased;
  final String receiveBy;
  final String reportreceiveDate;
  final String id;
  const LostAndFoundRoom(
      {super.key,
      required this.image,
      required this.founder,
      required this.itemName,
      required this.location,
      required this.time,
      required this.description,
      required this.status,
      required this.receiver,
      required this.statusReleased,
      required this.receiveBy,
      required this.id,
      required this.reportreceiveDate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Details Report',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        ),
        backgroundColor: Color(0xffF5F5F5),
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              color: mainColor,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              height: Get.height * 0.3,
              width: Get.width,
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(image))),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            NameItemBox(
                itemName: itemName,
                founder: founder,
                location: location,
                time: time),
            SizedBox(
              height: Get.height * 0.02,
            ),
            StatusBox(
              receiver: receiver,
              status: status,
              statusReleased: statusReleased,
              receiveBy: receiveBy,
              reportreceiveDate: reportreceiveDate,
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            DescriptionItem(description: description),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Expanded(child: Container()),
                  status == 'Released'
                      ? Consumer<ReportLFController>(
                          builder: (context, value, child) => Container(
                              width: Get.width * 0.5,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor:
                                          value.statusItem == 'Accepted'
                                              ? Colors.grey
                                              : mainColor),
                                  onPressed: value.statusItem == 'Accepted'
                                      ? null
                                      : () {
                                          Provider.of<ReportLFController>(
                                                  context,
                                                  listen: false)
                                              .receive(id, cUser.data.name!);
                                        },
                                  child: Text(
                                    'Receive',
                                    style: TextStyle(
                                        color: value.statusItem == 'Accepted'
                                            ? Colors.black45
                                            : Colors.white),
                                  ))))
                      : SizedBox(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
