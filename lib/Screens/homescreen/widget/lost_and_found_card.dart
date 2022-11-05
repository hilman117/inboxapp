import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../lf/lost_and_found_room.dart';
import 'status_report.dart';

class LFCard extends StatelessWidget {
  final String image;
  final String id;
  final String itemName;
  final String locationFound;
  final String founder;
  final String description;
  final String status;
  final String statusReleased;
  final String receiveBy;
  final String receiver;
  final String reportreceiveDate;
  final String time;
  const LFCard(
      {super.key,
      required this.image,
      required this.itemName,
      required this.locationFound,
      required this.founder,
      required this.description,
      required this.status,
      required this.receiver,
      required this.time,
      required this.id,
      required this.statusReleased,
      required this.receiveBy,
      required this.reportreceiveDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.7,
              offset: Offset(0.05, 0.05))
        ],
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      width: Get.width,
      child: Material(
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => Get.to(() => LostAndFoundRoom(
              image: image,
              founder: founder,
              itemName: itemName,
              location: locationFound,
              time: time,
              description: description,
              status: status,
              receiver: receiver,
              statusReleased: statusReleased,
              receiveBy: receiveBy,
              id: id,
              reportreceiveDate: reportreceiveDate)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(8),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(16)),
                child: Image.network(
                  image,
                  fit: BoxFit.fitWidth,
                ),
                height: Get.height * 0.12,
                width: Get.width * 0.3,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 10, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: Get.width * 0.35,
                        child: Text(
                          itemName,
                          style: TextStyle(fontSize: 16),
                          overflow: TextOverflow.clip,
                        )),
                    SizedBox(height: Get.height * 0.010),
                    Container(
                        width: Get.width * 0.35,
                        child: Text(
                          locationFound,
                          overflow: TextOverflow.clip,
                        )),
                    SizedBox(height: Get.height * 0.010),
                    Container(
                        width: Get.width * 0.35,
                        child: Text(
                          founder,
                          style: TextStyle(color: Colors.grey),
                          overflow: TextOverflow.clip,
                        )),
                    SizedBox(height: Get.height * 0.010),
                    Container(
                        width: Get.width * 0.35,
                        child: Text(
                          description,
                          style: TextStyle(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        )),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    StatusReport(status: status),
                    receiver.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Container(
                              alignment: Alignment.centerRight,
                              width: Get.width * 0.25,
                              child: Text(
                                'by $receiver',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              time,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                    receiver.isEmpty
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              time,
                              style: TextStyle(fontSize: 12),
                            ),
                          )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
