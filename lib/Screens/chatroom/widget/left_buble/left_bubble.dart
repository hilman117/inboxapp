import 'package:flutter/material.dart';
import 'package:post/Screens/chatroom/widget/right_bubble/accepted_bubble.dart';

import 'add_schedule_right.dart';
import 'assign_bubble_left.dart';
import 'bubble_edit_location_right.dart';
import 'delete_schedule_bubble.dart';
import 'hold_right.dart';
import 'left_message.dart';
import 'resume_right.dart';
import 'title_changes_right.dart';

class LeftBubble extends StatelessWidget {
  final List<dynamic> commentList;
  final String time;
  final String setDate;
  final String setTime;
  final String deleteSchedule;
  final String editLocation;
  final String resume;
  final String hold;
  final String senderMsgName;
  final String message;
  // String description,
  final String isAccepted;
  final String esc;
  final String titleChanging;
  final String assignSender;
  final String assignTo;
  final List<dynamic> image;
  const LeftBubble(
      {super.key,
      required this.commentList,
      required this.time,
      required this.senderMsgName,
      required this.isAccepted,
      required this.esc,
      required this.assignSender,
      required this.assignTo,
      required this.image,
      required this.message,
      required this.titleChanging,
      required this.setDate,
      required this.setTime,
      required this.deleteSchedule,
      required this.editLocation,
      required this.resume,
      required this.hold});

  @override
  Widget build(BuildContext context) {
    return Column(
      //buble chat yg tampil jika ada kita sbg pengirim pesan..................................
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        (isAccepted != '')
            ? SizedBox()
            : (assignTo != '')
                ? SizedBox()
                : (titleChanging != '')
                    ? SizedBox()
                    : (resume != '')
                        ? SizedBox()
                        : (hold != '')
                            ? SizedBox()
                            : (setTime != '')
                                ? SizedBox()
                                : (editLocation != '')
                                    ? SizedBox()
                                    : (deleteSchedule != '')
                                        ? SizedBox()
                                        : (message.isEmpty && image.isEmpty)
                                            ? SizedBox()
                                            : LeftMessage(
                                                commentList: commentList,
                                                time: time,
                                                message: message,
                                                image: image,
                                                senderMsgName: senderMsgName),
        //bubble ketike kita hold task
        hold == '' ? SizedBox() : HoldBubble(hold: hold, time: time),
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        //bubble ketike kita resume task
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isNotEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        resume == '' ? SizedBox() : Resume(resume: resume, time: time),
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isNotEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        //bubble ketike kita menambah kan shcedule
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isNotEmpty ||
                  setTime.isEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        setTime.isEmpty
            ? SizedBox()
            : AddSchedule(addSchedule: setDate + setTime, time: time),
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isNotEmpty ||
                  setTime.isEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        //bubble ketika kita menghapus schedule
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isNotEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        deleteSchedule == ''
            ? SizedBox()
            : DeleteScheduleBubble(deleteSchedule: deleteSchedule, time: time),
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isNotEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        //bubble ketika kita mengedit lokasi
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isNotEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        editLocation == ''
            ? SizedBox()
            : EditLoactionBubble(newLocation: editLocation, time: time),
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isNotEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        //bubble ketika kita menerima task...
        SizedBox(
          height: isAccepted.isEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isNotEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        (isAccepted == '')
            ? SizedBox()
            : AcceptedBubbleRight(time: time, isAccepted: isAccepted),
        SizedBox(
          height: isAccepted.isEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isNotEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        // widget yg ditampilkan ketika kita assign request ke user lain.......................
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isNotEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        assignTo == ''
            ? SizedBox()
            : AssignBubbleLeft(
                assignSender: assignSender, time: time, assignTo: assignTo),
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isEmpty ||
                  titleChanging.isNotEmpty ||
                  hold.isNotEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        //bubble ketika user mengganti title
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isEmpty ||
                  hold.isNotEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
        ),
        titleChanging == ''
            ? SizedBox()
            : TitleChangesRight(
                titleChanges: titleChanging,
                time: time,
                changer: senderMsgName),
        SizedBox(
          height: isAccepted.isNotEmpty ||
                  assignTo.isNotEmpty ||
                  titleChanging.isEmpty ||
                  hold.isNotEmpty ||
                  setTime.isNotEmpty ||
                  deleteSchedule.isNotEmpty ||
                  editLocation.isNotEmpty ||
                  resume.isNotEmpty ||
                  message.isNotEmpty
              ? 0
              : 5,
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
