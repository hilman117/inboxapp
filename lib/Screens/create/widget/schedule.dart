import 'package:flutter/material.dart';
import 'package:post/Screens/create/create_request_controller.dart';
import 'package:provider/provider.dart';


Widget schedulePicker(BuildContext context, double height, double widht) {
  return SizedBox(
    width: widht,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                : SizedBox()
          ],
        ),
        SizedBox(height: height * 0.01),
        InkWell(
          onTap: () =>
              Provider.of<CreateRequestController>(context, listen: false)
                  .dateTimePicker(context),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                height: height * 0.040,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.date_range, color: Colors.grey.shade900),
                    SizedBox(width: widht * 0.01),
                    Provider.of<CreateRequestController>(context).datePicked ==
                            ''
                        ? Text("Set Date")
                        : Text(
                            Provider.of<CreateRequestController>(context)
                                .datePicked,
                            style: const TextStyle(color: Colors.red)),
                  ],
                ),
              )),
              Expanded(
                  child: Container(
                height: height * 0.040,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.schedule_rounded, color:  Colors.grey.shade900),
                    SizedBox(width: widht * 0.01),
                    Provider.of<CreateRequestController>(context).timePicked ==
                            ''
                        ? Text("Set Time")
                        : Text(
                            Provider.of<CreateRequestController>(context)
                                .timePicked,
                            style: const TextStyle(color: Colors.red),
                          ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ],
    ),
  );
}
