import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../chatroom/widget/pop_up_menu/pop_up_menu_provider.dart';
import '../create_request_controller.dart';

Widget titleTile(BuildContext context, int index, String tasksId, String emailSender) {
  return InkWell(
    onTap: () {
      if (Provider.of<PopUpMenuProvider>(context, listen: false)
              .isTitleChange ==
          true) {
        Provider.of<PopUpMenuProvider>(context, listen: false)
            .storeNewTitle(context, tasksId, index, emailSender);
      } else {
        Provider.of<CreateRequestController>(context, listen: false)
            .selectTitle(context, index);
      }
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
          Provider.of<CreateRequestController>(context).title[index],
          style: TextStyle(fontWeight: FontWeight.w300),
          overflow: TextOverflow.clip,
        ),
      ),
    ),
  );
}
