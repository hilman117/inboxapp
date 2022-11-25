import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/dasboard/widget/card.dart';
import 'package:post/Screens/lf/lf_controller.dart';
import 'package:post/Screens/lf/widget/descriptions_item.dart';
import 'package:post/Screens/lf/widget/timeline_widget.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';

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
      extendBody: true,
      backgroundColor: Colors.white,
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
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.cover)),
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
            Consumer<ReportLFController>(
              builder: (context, value, child) => Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: Get.width * 0.5,
                    height: Get.height * 0.06,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: value.menu.length,
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () => Provider.of<ReportLFController>(
                                      context,
                                      listen: false)
                                  .changeIndex(index),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: value.currentIndex == index
                                        ? mainColor.withOpacity(0.2)
                                        : Colors.grey.shade100),
                                margin: EdgeInsets.all(8),
                                child: Text(
                                  value.menu[index],
                                  style: TextStyle(
                                      color: value.currentIndex == index
                                          ? mainColor
                                          : Colors.grey),
                                ),
                              ),
                            )),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  Provider.of<ReportLFController>(context).currentIndex == 0
                      ? DescriptionItem(description: description)
                      : Timeline(founder: founder)
                ],
              ),
            ),
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
