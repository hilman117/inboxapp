import 'package:flutter/material.dart';
import 'package:post/Screens/chatroom/widget/pop_up_menu/pop_up_menu_provider.dart';
import 'package:post/Screens/create/create_request_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:post/Screens/dasboard/widget/card.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';

Future addSchedule(BuildContext context, String taskId, String emailSender,
    String oldDate, String oldTime, String location) {
  final provider = Provider.of<CreateRequestController>(context, listen: false);
  final app = AppLocalizations.of(context)!;
  return showDialog(
      context: context,
      builder: (context) => Consumer<CreateRequestController>(
          builder: (context, value, child) => AlertDialog(
                contentPadding: EdgeInsets.all(20),
                content: Container(
                  height: height * 0.18,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        app.addDueDate,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      // container untuk pick new date
                      InkWell(
                        onTap: () => provider.dateTimPicker(context),
                        child: Container(
                          height: height * 0.05,
                          width: width,
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: mainColor,
                              ),
                              SizedBox(
                                width: width * 0.05,
                              ),
                              Text(value.datePicked),
                              Spacer(),
                              Icon(
                                Icons.edit,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      // container untuk pick new time
                      InkWell(
                        onTap: () => provider.timePIcker(context),
                        child: Container(
                          height: height * 0.05,
                          width: width,
                          child: Row(
                            children: [
                              Icon(
                                Icons.timer,
                                color: mainColor,
                              ),
                              SizedBox(
                                width: width * 0.05,
                              ),
                              Text(value.selectedTime),
                              Spacer(),
                              Icon(
                                Icons.edit,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  Container(
                    width: width * 0.25,
                    height: height * 0.04,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            elevation: 0, foregroundColor: mainColor),
                        onPressed: () async {
                          await Provider.of<CreateRequestController>(context,
                                  listen: false)
                              .cancelButton(oldDate, oldTime);
                          Provider.of<CreateRequestController>(context,
                                  listen: false)
                              .clear();
                          Navigator.pop(context);
                        },
                        child: Text(app.cancel)),
                  ),
                  Container(
                    width: width * 0.25,
                    height: height * 0.04,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0, backgroundColor: mainColor),
                      child: Text("Add"),
                      onPressed: value.newDate != '' || value.newTime != ''
                          ? () async {
                              try {
                                if (value.newDate != '') {
                                  Provider.of<PopUpMenuProvider>(context,
                                          listen: false)
                                      .storeNewDate(context, taskId, oldDate,
                                          emailSender, location);
                                }
                                if (value.newTime != '') {
                                  Provider.of<PopUpMenuProvider>(context,
                                          listen: false)
                                      .storeNewTime(context, taskId, oldTime,
                                          emailSender, location);
                                  Provider.of<CreateRequestController>(context,
                                          listen: false)
                                      .clear();
                                }
                                Navigator.pop(context);
                              } catch (e) {}
                            }
                          : null,
                    ),
                  ),
                ],
              )));
}
