import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../service/theme.dart';

class TitleChangesRight extends StatelessWidget {
  final String changer;
  final String titleChanges;
  final String time;
  const TitleChangesRight({required this.titleChanges, required this.time, required this.changer});

  @override
  Widget build(BuildContext context) {
    double size = Get.width + Get.height;
    return Container(
        // height: Get.height * 0.1,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: mainColor.withOpacity(0.5))),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.change_circle_rounded,
                size: size * 0.03, color: mainColor),
            Container(
              width: Get.width * 0.70,
              // color: Colors.blue.shade50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "$changer has change the title from $titleChanges",
                    style: TextStyle(
                        color: Colors.black87, fontSize: size * 0.012),
                    textAlign: TextAlign.end,
                  ),
                  Text(
                    time,
                    style: TextStyle(
                        fontSize: size * 0.01, color: Colors.grey, height: 1.5),
                  ),
                ],
              ),
            )
          ],
        )
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Container(
        //           alignment: Alignment.center,
        //           width: size * 0.25,
        //           child: Container(
        //             padding: EdgeInsets.all(10),
        //             decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(5),
        //                 color: Colors.green.shade50),
        //             child:
        // Text(
        // "$isAccepted ${AppLocalizations.of(context)!.hasAcceptThisRequest}",
        //               style:
        //                   TextStyle(color: Colors.black87, fontSize: size * 0.01),
        //               textAlign: TextAlign.start,
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //     Text(
        //       time,
        //       style: TextStyle(fontSize: 10, color: Colors.grey, height: 1.5),
        //     ),
        //   ],
        // ),
        );
  }
}
