import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:post/Screens/create/create_request_controller.dart';
import 'package:provider/provider.dart';

import '../../../service/theme.dart';

Widget chooseImage(BuildContext context, double height, double widht) {
  return DottedBorder(
    borderType: BorderType.RRect,
    radius: const Radius.circular(10),
    color: mainColor,
    child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.center,
        width: double.infinity,
        height: height * 0.090,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Provider.of<CreateRequestController>(context).images == null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/upload.png",
                    width: widht * 0.1,
                    height: height * 0.05,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    width: widht * 0.03,
                  ),
                  Text(
                    "Upload Image",
                    style: TextStyle(color: mainColor),
                  )
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: height * 0.1,
                    width: widht * 0.2,
                    child: Image.file(
                        Provider.of<CreateRequestController>(context).images!,
                        fit: BoxFit.cover),
                  ),
                  CloseButton(
                    color: Colors.grey,
                    onPressed: () => Provider.of<CreateRequestController>(
                            context,
                            listen: false)
                        .clearImage(),
                  )
                ],
              )),
  );
}
