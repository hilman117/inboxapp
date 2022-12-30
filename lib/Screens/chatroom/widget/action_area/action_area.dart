import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../global_function.dart';
import '../../../../common_widget/card.dart';
import '../../chatroom_controller.dart';
import '../assign/assign_dialog.dart';
import '../close_dialog.dart';
import 'widget/button_action.dart';
import 'widget/keyboard/keyboard.dart';
import 'widget/list_images_comment.dart';

class ActionArea extends StatelessWidget {
  final String taskId;
  final String location;
  final String titleTask;
  final String emailSender;
  final String sendTo;
  final String setTime;
  final String setDate;
  final String fromWhere;
  final ScrollController scrollController;
  const ActionArea({
    super.key,
    required this.taskId,
    required this.location,
    required this.titleTask,
    required this.emailSender,
    required this.sendTo,
    required this.fromWhere,
    required this.scrollController,
    required this.setTime,
    required this.setDate,
  });

  @override
  Widget build(BuildContext context) {
    final app = AppLocalizations.of(context);
    final provider = Provider.of<ChatRoomController>(context, listen: false);
    return SizedBox(
      width: double.infinity,
      child: Consumer<ChatRoomController>(
        builder: (context, value, child) => AnimatedSwitcher(
          switchInCurve: Curves.easeInSine,
          switchOutCurve: Curves.easeOutSine,
          duration: Duration(seconds: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.04,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    value.status == "Close"
                        ? SizedBox()
                        : buttonAction(app!.close, () {
                            closeDialog(context, taskId, location, titleTask,
                                scrollController, emailSender, sendTo);
                          }, value.status),
                    value.status == "Close"
                        ? buttonAction(app!.reopen, () {
                            provider.reopen(context, taskId, location,
                                titleTask, scrollController, sendTo);
                          }, value.status)
                        : buttonAction(app!.assign, () async {
                            assign(context, taskId, emailSender, location,
                                titleTask, scrollController);
                            await provider.getDeptartementAndNames();
                          }, value.status),
                    value.status == "Close"
                        ? SizedBox()
                        : buttonAction(app.accept, () {
                            if (Provider.of<GlobalFunction>(context,
                                        listen: false)
                                    .hasInternetConnection ==
                                true) {
                              value.receiver == cUser.data.name
                                  ? Fluttertoast.showToast(
                                      textColor: Colors.black,
                                      backgroundColor: Colors.white,
                                      msg: "You have received this request")
                                  : provider.accept(
                                      context,
                                      taskId,
                                      emailSender,
                                      location,
                                      titleTask,
                                      scrollController,
                                      sendTo);
                            } else {
                              Provider.of<GlobalFunction>(context,
                                      listen: false)
                                  .noInternet();
                            }
                          }, value.status),
                  ],
                ),
              ),
              SizedBox(height: 10),
              value.status == "Close"
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: keyboardChat(
                          context: context,
                          deptTujuan: sendTo,
                          deptSender: fromWhere,
                          location: location,
                          scroll: scrollController,
                          taskId: taskId,
                          title: titleTask,
                          emailSender: emailSender,
                          oldDate: setDate,
                          oldTime: setTime),
                    ),
              value.imagesList.isNotEmpty ? ListImagesComment() : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
