import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../chatroom_controller.dart';

Widget listOfEmployee(
    BuildContext context, String name, String email, int index) {
  return StatefulBuilder(
    builder: (context, setState) => Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1, color: Colors.white),
              top: BorderSide(width: 1, color: Colors.white))),
      child: Consumer<ChatRoomController>(
          builder: (context, value, child) => SwitchListTile(
                title: Text(
                  name,
                  style: TextStyle(
                      color: value.statusDutyList[index] == true
                          ? Colors.grey
                          : Colors.red),
                ),
                activeColor: Colors.blue,
                activeTrackColor: Color(0xff007dff),
                inactiveTrackColor: Colors.grey,
                onChanged: (value) {
                  Provider.of<ChatRoomController>(context, listen: false)
                      .selectFucntionEmployee(value, index);
                },
                value: value.boolLlistemployee![index],
              )),
    ),
  );
}
