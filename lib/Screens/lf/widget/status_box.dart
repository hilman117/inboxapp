import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/lf/lf_controller.dart';
import 'package:provider/provider.dart';

import '../../homescreen/widget/status_report.dart';

class StatusBox extends StatelessWidget {
  final String receiver;
  final String status;
  final String statusReleased;
  final String receiveBy;
  final String reportreceiveDate;
  const StatusBox(
      {super.key,
      required this.receiver,
      required this.status,
      required this.statusReleased,
      required this.receiveBy,
      required this.reportreceiveDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: Get.width,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Status:',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: Get.height * 0.001),
          Container(
              width: Get.width * 0.2, child: StatusReport(status: status)),
          SizedBox(height: Get.height * 0.001),
          status == 'New'
              ? SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width * 0.55,
                      child: Text(
                        'Receiver: $receiver',
                        style: TextStyle(color: Colors.grey, height: 1.5),
                      ),
                    ),
                    Text(
                      '22, apriil 2022, 09.09',
                      style: TextStyle(color: Colors.grey, height: 1.5),
                    ),
                  ],
                ),
          SizedBox(height: Get.height * 0.001),
          status == 'Claimed' || status == 'Released'
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.width * 0.55,
                      child: Text(
                        'Issued by: $receiver',
                        style: TextStyle(color: Colors.grey, height: 1.5),
                      ),
                    ),
                    Text(
                      '22, apriil 2022, 09.09',
                      style: TextStyle(color: Colors.grey, height: 1.5),
                    ),
                  ],
                )
              : SizedBox(),
          SizedBox(height: Get.height * 0.001),
          Provider.of<ReportLFController>(context).statusItem == 'Accepted'
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.width * 0.55,
                      child: Consumer<ReportLFController>(
                          builder: (context, value, child) => Text(
                                'Received by: ${value.receiveByFounder}',
                                style:
                                    TextStyle(color: Colors.grey, height: 1.5),
                              )),
                    ),
                    Text(
                      reportreceiveDate,
                      style: TextStyle(color: Colors.grey, height: 1.5),
                    ),
                  ],
                )
              : SizedBox()
        ],
      ),
    );
  }
}
