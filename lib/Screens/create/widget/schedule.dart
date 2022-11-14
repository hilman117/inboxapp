import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/create/create_request_controller.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';

class SchedulePicker extends StatelessWidget {
  const SchedulePicker({super.key});

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    return Consumer<CreateRequestController>(
        builder: (context, value, child) => SizedBox(
              width: width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value.isLfReport ? '- - - - ' : "Set Schedule",
                      style: TextStyle(
                          color: value.isLfReport ? Colors.grey : Colors.black),
                    ),
                    value.datePicked != ''
                        ? InkWell(
                            onTap: () => Provider.of<CreateRequestController>(
                                    context,
                                    listen: false)
                                .clearSchedule(),
                            child: Text(
                              "clear schedule",
                              style: const TextStyle(color: Colors.blue),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(height: height * 0.01),
                    InkWell(
                      onTap: value.isLfReport
                          ? null
                          : () => Provider.of<CreateRequestController>(context,
                                  listen: false)
                              .dateTimePicker(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: value.isLfReport
                                ? Colors.grey.withOpacity(0.2)
                                : mainColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12)),
                        width: Get.width,
                        height: Get.height * 0.06,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            value.datePicked == ''
                                ? Text(
                                    value.isLfReport ? '- - - -' : 'dd/mm/yyyy',
                                    style: TextStyle(color: Colors.black38),
                                  )
                                : Text(value.datePicked,
                                    style: const TextStyle(color: Colors.red)),
                            value.isLfReport
                                ? SizedBox()
                                : Image.asset(
                                    'images/date.png',
                                    width: 20,
                                  )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: value.isLfReport
                              ? Colors.grey.withOpacity(0.2)
                              : mainColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12)),
                      width: Get.width,
                      height: Get.height * 0.06,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          value.timePicked == ''
                              ? Text(
                                  value.isLfReport ? '- - - - ' : '00.00',
                                  style: TextStyle(
                                      color: value.isLfReport
                                          ? Colors.grey
                                          : Colors.black38),
                                )
                              : Text(
                                  value.timePicked,
                                  style: const TextStyle(color: Colors.red),
                                ),
                          value.isLfReport
                              ? SizedBox()
                              : Image.asset(
                                  'images/time.png',
                                  width: 20,
                                )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
