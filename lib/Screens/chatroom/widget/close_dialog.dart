import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../dasboard/widget/card.dart';
import '../chatroom_controller.dart';

void closeDialog(context, String taskId, String location, String title,
    ScrollController scroll, String email, String deptTujuan) {
  final app = AppLocalizations.of(context);
  TextEditingController closetext = TextEditingController();
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            alignment: Alignment.center,
            height: Get.height * 0.15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  app!.areYouSureWantToCloseThisRequest,
                  style: TextStyle(fontSize: 14),
                ),
                Container(
                  padding: EdgeInsets.only(top: 6),
                  height: Get.height * 0.050,
                  width: Get.width * 0.60,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: closetext,
                    decoration: InputDecoration(
                        isDense: true,
                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                        hintText: app.typeHere,
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: Get.height * 0.035,
                      width: Get.width * 0.25,
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(color: mainColor),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4))),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            app.no,
                            style: TextStyle(color: cardColor),
                          )),
                    ),
                    SizedBox(
                      height: Get.height * 0.035,
                      width: Get.width * 0.25,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: mainColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4))),
                          onPressed: () {
                            Provider.of<ChatRoomController>(context,
                                    listen: false)
                                .close(context, taskId, location, title, scroll,
                                    closetext.text, email, deptTujuan);
                          },
                          child: Text(app.yes)),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}
