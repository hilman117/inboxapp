import 'package:flutter/material.dart';
import 'package:post/Screens/chatroom/widget/pop_up_menu/pop_up_menu_provider.dart';
import 'package:provider/provider.dart';

import '../../../create/create_request_controller.dart';

Widget locationCard(BuildContext context, int index, String tasksId,
    String emailSender, String oldLocation) {
  final procider = Provider.of<CreateRequestController>(context);
  return InkWell(
    onTap: () {
      Provider.of<PopUpMenuProvider>(context, listen: false).storeNewLocation(
          context, tasksId, oldLocation, emailSender, procider.data[index]);
    },
    child: Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(width: 0.5, color: Colors.grey.shade300))),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          procider.data[index],
          style: TextStyle(fontWeight: FontWeight.w300),
          overflow: TextOverflow.clip,
        ),
      ),
    ),
  );
}
