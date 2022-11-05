import 'package:flutter/material.dart';
import 'package:post/Screens/homescreen/home_controller.dart';
import 'package:provider/provider.dart';

import '../../../service/theme.dart';

Widget typing(BuildContext context) {
  return Row(
    children: [
      CloseButton(
        color: Colors.grey,
        onPressed: () {
          context.read<HomeController>().changeValue();
        },
      ),
      Expanded(
        child: SizedBox(
          child: TextFormField(
            cursorColor: mainColor,
            autofocus: true,
            style: const TextStyle(fontSize: 15),
            cursorHeight: 15,
            decoration: const InputDecoration(
              hintText: "type here ...",
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    ],
  );
}
