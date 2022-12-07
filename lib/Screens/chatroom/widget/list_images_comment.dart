import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:post/Screens/chatroom/chatroom_controller.dart';
import 'package:post/Screens/chatroom/widget/image_picker.dart';
import 'package:provider/provider.dart';

class ListImagesComment extends StatelessWidget {
  const ListImagesComment({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Consumer<ChatRoomController>(
          builder: (context, value, child) => Container(
              height: height * 0.1,
              width: width * 0.9,
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: value.imagesList.length,
                      (BuildContext context, int index) {
                        if (value.imagesList[index] != null) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            width: width * 0.25,
                            child: Stack(
                              children: [
                                Container(
                                  height: height * 0.1,
                                  width: width * 0.2,
                                  child: Image.file(
                                    File(value.imagesList[index]!.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                value.isImageLoad == true
                                    ? Container(
                                        color: Colors.black45,
                                        height: height * 0.1,
                                        width: width * 0.2,
                                        child: Lottie.asset(
                                            "images/loadimage.json"))
                                    : SizedBox(),
                                Positioned(
                                  left: width * 0.13,
                                  bottom: height * 0.05,
                                  child: IconButton(
                                    padding: EdgeInsets.all(0),
                                    icon: Icon(Icons.cancel_outlined),
                                    color: Colors.red,
                                    onPressed: () =>
                                        Provider.of<ChatRoomController>(context,
                                                listen: false)
                                            .removeSingleImage(index),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300)),
                    padding: EdgeInsets.all(8),
                    child: IconButton(
                        splashRadius: 20,
                        constraints: BoxConstraints(),
                        padding: EdgeInsets.zero,
                        onPressed: () => imagePicker(context, height, width),
                        icon: Icon(
                          Icons.add_circle_outline_outlined,
                          color: Colors.grey,
                        )),
                  )),
                ],
              )),
        )
      ],
    );
  }
}
