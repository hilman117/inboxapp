import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';

import '../../create/create_request.dart';
import '../../create/create_request_controller.dart';
import '../../dasboard/widget/card.dart';

Widget addButton(BuildContext context, double height, double widht) {
  return Tooltip(
    textStyle: const TextStyle(color: Colors.black45),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1, color: Colors.black45)),
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
    message: "Create Task",
    child: Container(
      height: Get.height * 0.070,
      width: Get.width * 0.15,
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          Provider.of<CreateRequestController>(context, listen: false)
              .clearData();
          Provider.of<CreateRequestController>(context, listen: false)
              .clearSchedule();
          Provider.of<CreateRequestController>(context, listen: false)
              .getLocation(cUser.data.hotelid!);
          await Get.to(() => CreateRequest(),
              transition: Transition.rightToLeft);
        },
        child: Icon(
          Icons.add,
          color: mainColor,
        ),
      ),
    ),
  );
}
