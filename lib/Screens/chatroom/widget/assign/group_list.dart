import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../chatroom_controller.dart';

Widget listOfGroup(String dept, int index) {
  return StatefulBuilder(
    builder: (context, setState) => Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1, color: Colors.white),
              top: BorderSide(width: 1, color: Colors.white))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            dept,
            style: TextStyle(color: Colors.grey),
          ),
          Consumer<ChatRoomController>(
              builder: (context, value, child) => Switch(
                    activeColor: Colors.blue,
                    activeTrackColor: Color(0xff007dff),
                    inactiveTrackColor: Colors.grey,
                    onChanged: (value) {
                      Provider.of<ChatRoomController>(context, listen: false)
                          .selectFucntionGroup(value, index);
                    },
                    value: value.boolLlistGroup![index],
                  )),
        ],
      ),
    ),
  );
}
