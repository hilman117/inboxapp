import 'package:flutter/material.dart';
import 'package:post/global_function.dart';
import 'package:provider/provider.dart';

import '../../../../../../../common_widget/card.dart';
import '../../../../../chatroom_controller.dart';
import '../../../../pop_up_menu/pop_up_menu.dart';

class SendAndMoreButton extends StatelessWidget {
  final String taskId;
  final String location;
  final String title;
  final String emailSender;
  final String deptTujuan;
  final String deptSender;
  final String oldTime;
  final String oldDate;
  final ScrollController scroll;
  const SendAndMoreButton(
      {super.key,
      required this.taskId,
      required this.location,
      required this.title,
      required this.emailSender,
      required this.deptTujuan,
      required this.deptSender,
      required this.oldTime,
      required this.oldDate,
      required this.scroll});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatRoomController>(
        builder: (context, value, child) => AnimatedSwitcher(
            duration: Duration.zero,
            switchOutCurve: Curves.easeOutSine,
            child: Container(
                height: height * 0.03,
                width: width * 0.2,
                decoration: BoxDecoration(),
                child: value.isTypping || value.imagesList.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          if (Provider.of<GlobalFunction>(context,
                                      listen: false)
                                  .hasInternetConnection ==
                              true) {
                            Provider.of<ChatRoomController>(context,
                                    listen: false)
                                .sendComment(taskId, location, title, scroll,
                                    deptSender, deptTujuan);
                          } else {
                            Provider.of<GlobalFunction>(context, listen: false)
                                .noInternet();
                          }
                        },
                        child: Image.asset(
                          'images/send1.png',
                          width: 30,
                        ),
                      )
                    : InkWell(
                        onTap: Provider.of<ChatRoomController>(context,
                                        listen: false)
                                    .status !=
                                "Close"
                            ? () => showPopUpMenu(context, deptTujuan, taskId,
                                emailSender, oldDate, oldTime, location)
                            : () {},
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.black54,
                        ),
                      ))));
  }
}
