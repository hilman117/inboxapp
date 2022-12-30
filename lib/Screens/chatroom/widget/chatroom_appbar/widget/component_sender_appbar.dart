import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:post/Screens/chatroom/chatroom_controller.dart';
import 'package:post/Screens/create/create_request_controller.dart';
import 'package:post/common_widget/card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../service/theme.dart';
import '../../../../../common_widget/status.dart';

class ComponentSenderAppBar extends StatelessWidget {
  final String sendTo;
  final String taskId;
  final String emailSender;
  final String location;
  final DateTime timeCreated;
  const ComponentSenderAppBar(
      {super.key,
      required this.sendTo,
      required this.timeCreated,
      required this.taskId,
      required this.emailSender,
      required this.location});

  @override
  Widget build(BuildContext context) {
    final applications = AppLocalizations.of(context);

    return Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.symmetric(horizontal: width * 0.02),
        padding: EdgeInsets.all(5),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  blurRadius: 4,
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 0.5,
                  offset: Offset(1, 1))
            ]),
        child: Consumer<ChatRoomController>(
          builder: (context, value, child) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: height * 0.03,
                      width: width * 0.07,
                      child: Image.asset('images/$sendTo.png')),
                  SizedBox(
                    width: width * 0.01,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sent to $sendTo",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54),
                      ),
                      SizedBox(
                        height: height * 0.005,
                      ),
                      Text(
                        "${DateFormat('EE, MMM d, hh:mm').format(timeCreated)}",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                      height: height * 0.033,
                      child: StatusWidget(
                        status: value.status,
                        isFading: false,
                        height: height * 0.013,
                        fontSize: 10,
                      )),
                  (value.status != 'Assigned')
                      ? Container(
                          margin: EdgeInsets.only(top: height * 0.005),
                          width: width * 0.46,
                          child: value.receiver != ''
                              ? Text(
                                  value.status != 'Assigned'
                                      ? "${applications!.by} ${value.receiver}"
                                      : "${applications!.to} ${value.assignTo}",
                                  style:
                                      TextStyle(color: secondary, fontSize: 11),
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.end,
                                )
                              : SizedBox(height: height * 0.005),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: height * 0.005),
                          width: width * 0.46,
                          child: value.status == 'Assigned'
                              ? Text(
                                  "${applications!.to} ${value.assignTo}",
                                  style:
                                      TextStyle(color: secondary, fontSize: 11),
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.end,
                                )
                              : SizedBox(height: height * 0.000),
                        ),
                  Consumer<CreateRequestController>(
                    builder: (context, val, child) => (val.datePicked != '' ||
                            val.selectedTime != '')
                        ? Container(
                            width: width * 0.40,
                            child: Text(
                              "${DateFormat("EE d").format(DateTime.parse(val.datePicked))}, ${val.selectedTime}",
                              style: TextStyle(color: Colors.red, fontSize: 12),
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.end,
                            ),
                          )
                        : SizedBox(),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
