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
  final Color colors;
  const GeneralForm(
      {super.key,
      required this.title,
      required this.hintForm,
      required this.callback,
      required this.icons,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Consumer<CreateRequestController>(
          builder: (context, value, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width * 0.25,
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: Get.height * 0.07,
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                          onTap: value.isLfReport && title == 'Send this to'
                              ? null
                              : callback,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: Get.height * 0.06,
                            decoration: BoxDecoration(
                                color: colors.withOpacity(0.2),
                                borderRadius:
                                    BorderRadiusDirectional.circular(12)),
                            child: Row(
                              children: [
                                value.isLfReport
                                    ? Expanded(
                                        child: Container(
                                            child: value.isLfReport &&
                                                    title == 'Send this to'
                                                ? Text(title,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15))
                                                : TextFormField(
                                                    controller: value.nameItem,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black54,
                                                    ),
                                                    cursorHeight: 14,
                                                    cursorColor: mainColor,
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    decoration: InputDecoration(
                                                        hintText: hintForm,
                                                        hintStyle: TextStyle(
                                                            color:
                                                                Colors.black38),
                                                        isDense: true,
                                                        border:
                                                            InputBorder.none),
                                                  )))
                                    : Text(
                                        hintForm,
                                        style: const TextStyle(
                                            color: Colors.black45),
                                      ),
                                value.isLfReport ? SizedBox() : Spacer(),
                                Icon(
                                  value.isLfReport && title == 'Send this to'
                                      ? Icons.cancel
                                      : icons,
                                  color: value.isLfReport &&
                                          title == 'Send this to'
                                      ? Colors.grey
                                      : secondary,
                                  size: 20,
                                ),
                              ],
                            ),
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
