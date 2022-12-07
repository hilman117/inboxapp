import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../dasboard/widget/card.dart';

class AssignBubnleRight extends StatelessWidget {
  final String assignSender;
  final String assignTo;
  final String time;
  const AssignBubnleRight(
      {required this.assignSender, required this.time, required this.assignTo});

  @override
  Widget build(BuildContext context) {
    double size = Get.width + Get.height;
    return Container(
        margin: EdgeInsets.only(left: width * 0.2),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)),
            border: Border.all(color: Color(0xffD5DFF3))),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: width * 0.08,
                    height: height * 0.05,
                    child: Image.asset("images/assign.png")),
                Text(
                  time,
                  style: TextStyle(
                      fontSize: size * 0.01, color: Colors.grey, height: 1.5),
                ),
              ],
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  "$assignSender ${AppLocalizations.of(context)!.hasAssignThisRequestTo} $assignTo",
                  style:
                      TextStyle(color: Colors.black87, fontSize: size * 0.012),
                  textAlign: TextAlign.end,
                ),
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
