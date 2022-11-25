import 'package:flutter/material.dart';
import 'package:post/Screens/chatroom/widget/right_bubble/accepted_bubble.dart';

import 'assign_bubble_right.dart';
import 'my_message.dart';

class RightBubble extends StatelessWidget {
  final List<dynamic> commentList;
  final String time;
  final String senderMsgName;
  final String message;
  // String description,
  final String isAccepted;
  final String esc;
  final String assignSender;
  final String assignTo;
  final String image;
  const RightBubble(
      {super.key,
      required this.commentList,
      required this.time,
      required this.senderMsgName,
      required this.isAccepted,
      required this.esc,
      required this.assignSender,
      required this.assignTo,
      required this.image,
      required this.message});

  @override
  Widget build(BuildContext context) {
   return Column(
    //buble chat yg tampil jika ada kita sbg pengirim pesan..................................
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      (isAccepted != '')
          ? SizedBox()
          : (assignSender != '')
              ? SizedBox()
              : (message.isEmpty && image.isEmpty)
                  ? SizedBox()
                  : MyMessage(
                      commentList: commentList,
                      time: time,
                      message: message,
                      image: image,
                      senderMsgName: senderMsgName),
      //widget pesan yg ditampilkan ketika status diterima............
      SizedBox(
        height: isAccepted == '' ? 0 : 10,
      ),
      (isAccepted == '')
          ? SizedBox()
          : (assignSender != '')
              ? SizedBox()
              : AcceptedBubbleRight(time: time, isAccepted: isAccepted),
      SizedBox(
        height: isAccepted == '' ? 0 : 10,
      ),
      // widget yg ditampilkan ketika kita assign request ke user lain.......................
      SizedBox(
        height: assignSender == '' ? 0 : 10,
      ),
      assignSender == ''
          ? SizedBox()
          : AssignBubnleRight(
              assignSender: assignSender, time: time, assignTo: assignTo),
      SizedBox(
        height: assignSender == '' ? 0 : 10,
      ),
      // status esc................................
      SizedBox(
        height: esc == '' ? 0 : 10,
      ),
      esc == ''
          ? SizedBox()
          : SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 40,
                    child: Text(
                      "Jun 03, 09.00 AM",
                      style: TextStyle(
                          fontSize: 10, color: Colors.grey, height: 1.5),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        width: 250,
                        child: const Text(
                          "Escalation after 5 minutes",
                          style: TextStyle(color: Colors.black87),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.history,
                        color: Colors.blue,
                        size: 30,
                      ),

                      // Icon(
                      //   Icons.check_circle,
                      //   color: Colors.green,
                      // ),
                    ],
                  ),
                ],
              ),
            ),
      SizedBox(
        height: esc == '' ? 0 : 10,
      ),
    ],
  );
  }
}
