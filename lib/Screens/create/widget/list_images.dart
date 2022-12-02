import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/create/create_request_controller.dart';
import 'package:post/Screens/create/widget/bottom_sheet_image_picker.dart';
import 'package:provider/provider.dart';

class ListImages extends StatelessWidget {
  const ListImages({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Consumer<CreateRequestController>(
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
                                SizedBox(
                                  height: height * 0.1,
                                  width: width * 0.2,
                                  child: Image.file(
                                    File(value.imagesList[index]!.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  left: width * 0.13,
                                  bottom: height * 0.05,
                                  child: IconButton(
                                    padding: EdgeInsets.all(0),
                                    icon: Icon(Icons.cancel_outlined),
                                    color: Colors.red,
                                    onPressed: () =>
                                        Provider.of<CreateRequestController>(
                                                context,
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
                        onPressed: () => imagePicker(context),
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
