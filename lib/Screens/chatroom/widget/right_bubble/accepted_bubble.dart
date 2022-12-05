import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:post/Screens/dasboard/widget/card.dart';

class AcceptedBubbleRight extends StatelessWidget {
  final String isAccepted;
  final String time;
  const AcceptedBubbleRight({required this.isAccepted, required this.time});

  @override
  Widget build(BuildContext context) {
    double size = Get.width + Get.height;
    return Container(
        margin: EdgeInsets.only(left: width * 0.2),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)),
            border: Border.all(color: Colors.green.shade100)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: width * 0.07,
                height: height * 0.04,
                child: Image.asset("images/accepted.png")),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      child: Text(
                        "$isAccepted ${AppLocalizations.of(context)!.hasAcceptThisRequest}",
                        style: TextStyle(
                            color: Colors.black87, fontSize: size * 0.012),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                          fontSize: size * 0.01,
                          color: Colors.grey,
                          height: 1.5),
                    ),
                  ],
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
