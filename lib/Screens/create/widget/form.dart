import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/create/create_request_controller.dart';
import 'package:provider/provider.dart';

import '../../../service/theme.dart';

Color themeColor = const Color(0xffF8CCA5);
Color cardColor = const Color(0xff475D5B);

class GeneralForm extends StatelessWidget {
  final String title;
  final String hintForm;
  final VoidCallback callback;
  final IconData icons;
  const GeneralForm(
      {super.key,
      required this.title,
      required this.hintForm,
      required this.callback,
      required this.icons});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.center,
          width: double.infinity,
          height: Get.height * 0.05,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              Container(
                width: Get.width * 0.25,
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.black54, fontSize: 15),
                ),
              ),
              Expanded(
                child: InkWell(
                    onTap: callback,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: Get.height * 0.05,
                      decoration: BoxDecoration(
                          color: Color(0xffF5F5F5),
                          borderRadius: BorderRadiusDirectional.circular(10)),
                      child: Consumer<CreateRequestController>(
                        builder: (context, value, child) => Row(
                          children: [
                            value.isLfReport
                                ? Expanded(
                                    child: Container(
                                        child: TextFormField(
                                    controller: value.nameItem,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                    cursorHeight: 14,
                                    cursorColor: mainColor,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                        hintText: hintForm,
                                        hintStyle:
                                            TextStyle(color: Colors.black45),
                                        isDense: true,
                                        border: InputBorder.none),
                                  )))
                                : Text(
                                    hintForm,
                                    style:
                                        const TextStyle(color: Colors.black45),
                                  ),
                            value.isLfReport ? SizedBox() : Spacer(),
                            Icon(
                              icons,
                              color: mainColor,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    )),
              )
            ],
          ),
        )
      ],
    );
  }
}
