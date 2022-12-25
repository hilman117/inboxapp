import 'package:flutter/material.dart';
import '../../../chatroom/widget/left_buble/left_message.dart';
import 'accept_bubble_left.dart';

class LfLeftBubble extends StatelessWidget {
  final List<dynamic> commentList;
  final String time;
  final String senderMsgName;
  final String message;
  // String description,
  final String isAccepted;
  final List<dynamic> image;
  const LfLeftBubble(
      {super.key,
      required this.commentList,
      required this.time,
      required this.senderMsgName,
      required this.isAccepted,
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
                : (message.isEmpty && image.isEmpty)
                    ? SizedBox()
                    : LeftMessage(
                        commentList: commentList,
                        time: time,
                        message: message,
                        image: image,
                        senderMsgName: senderMsgName),
        //bubble ketika kita menerima task...
        SizedBox(
          height:
              isAccepted.isEmpty || message.isNotEmpty
                  ? 0
                  : 5,
        ),
        (isAccepted == '')
            ? SizedBox()
            : AcceptedBubbleLeft(time: time, isAccepted: isAccepted),
        SizedBox(
          height:
              isAccepted.isEmpty || message.isNotEmpty
                  ? 0
                  : 5,
        ),
      ],
    );
  }
}
