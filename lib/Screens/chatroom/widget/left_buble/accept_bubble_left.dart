import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../service/theme.dart';

class AcceptedBubbleLeft extends StatelessWidget {
  final String isAccepted;
  final String time;
  const AcceptedBubbleLeft({required this.isAccepted, required this.time});

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
            Container(
              width: Get.width * 0.70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$isAccepted ${AppLocalizations.of(context)!.hasAcceptThisRequest}",
                    style: TextStyle(
                        color: Colors.black87, fontSize: size * 0.012),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    time,
                    style: TextStyle(
                        fontSize: size * 0.01, color: Colors.grey, height: 1.5),
                  ),
                ],
              ),
            ),
            Icon(Icons.check_circle_rounded,
                size: size * 0.03, color: mainColor),
          ],
        ));
  }
}
