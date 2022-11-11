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
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Set Schedule"),
            Provider.of<CreateRequestController>(context).datePicked != ''
                ? InkWell(
                    onTap: () => Provider.of<CreateRequestController>(context,
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
              onTap: () =>
                  Provider.of<CreateRequestController>(context, listen: false)
                      .dateTimePicker(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: mainColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12)),
                width: Get.width,
                height: Get.height * 0.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Provider.of<CreateRequestController>(context).datePicked ==
                            ''
                        ? Text(
                            'dd/mm/yyyy',
                            style: TextStyle(color: Colors.black38),
                          )
                        : Text(
                            Provider.of<CreateRequestController>(context)
                                .datePicked,
                            style: const TextStyle(color: Colors.red)),
                    Image.asset(
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
                  color: mainColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12)),
              width: Get.width,
              height: Get.height * 0.06,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Provider.of<CreateRequestController>(context).timePicked == ''
                      ? Text(
                          '00.00',
                          style: TextStyle(color: Colors.black38),
                        )
                      : Text(
                          Provider.of<CreateRequestController>(context)
                              .timePicked,
                          style: const TextStyle(color: Colors.red),
                        ),
                  Image.asset(
                    'images/time.png',
                    width: 20,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
