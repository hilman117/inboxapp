import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:post/Screens/homescreen/home_controller.dart';
import 'package:post/Screens/settings/widget/log_out_dialog.dart';
import 'package:post/Screens/settings/setting_provider.dart';
import 'package:post/controller/c_user.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import 'widget/dialog_change_photo.dart';
import 'widget/setting_menu.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cUser = Get.put(CUser());
    final provider = Provider.of<SettingProvider>(context, listen: false);
    return Consumer<SettingProvider>(
        builder: (context, value, child) => Scaffold(
              appBar: AppBar(
                elevation: 0,
                bottom: PreferredSize(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => imagePickerProfile(context),
                            child: CircleAvatar(
                              child: value.isLoading
                                  ? CircularProgressIndicator()
                                  : SizedBox(),
                              backgroundColor: Colors.grey,
                              foregroundImage: NetworkImage(value.imageUrl),
                              // backgroundImage: AssetImage('images/nophoto.png'),
                            ),
                          ),
                          SizedBox(width: Get.width * 0.02),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cUser.data.name!,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18),
                              ),
                              SizedBox(height: 3),
                              Text(
                                cUser.data.position!,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    preferredSize: Size.fromHeight(15)),
                backgroundColor: Colors.white,
              ),
              body: ModalProgressHUD(
                inAsyncCall: value.isLoad,
                progressIndicator: CircularProgressIndicator(
                  color: Colors.orange,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: Column(
                    children: [
                      settingMenu(
                        "Do you want to be notified when your requests are accepted?",
                        Consumer<SettingProvider>(
                            builder: (context, value, child) => Switch(
                                  activeColor: mainColor,
                                  activeTrackColor: mainColor,
                                  inactiveTrackColor: Colors.orange,
                                  onChanged: (bool bool) async {
                                    await provider.accepted(bool);
                                  },
                                  value: box!.get('ReceiveNotifWhenAccepted') ==
                                          null
                                      ? true
                                      : box!.get('ReceiveNotifWhenAccepted'),
                                )),
                        () {},
                      ),
                      settingMenu(
                        "Do you want to be notified when your requests are closed?",
                        Consumer<SettingProvider>(
                            builder: (context, value, child) => Switch(
                                  activeColor: mainColor,
                                  activeTrackColor: mainColor,
                                  inactiveTrackColor: Colors.orange,
                                  onChanged: (bool bool) {
                                    provider.close(bool);
                                  },
                                  value:
                                      box!.get('ReceiveNotifWhenClose') == null
                                          ? true
                                          : box!.get('ReceiveNotifWhenClose'),
                                )),
                        () {},
                      ),
                      settingMenu(
                        "Do yo want to send notification when you update a chat?",
                        Consumer<SettingProvider>(
                            builder: (context, value, child) => Switch(
                                  activeColor: mainColor,
                                  activeTrackColor: mainColor,
                                  inactiveTrackColor: Colors.orange,
                                  onChanged: (bool bool) {
                                    provider.sendNotif(bool);
                                  },
                                  value: box!.get('sendNotification') == null
                                      ? true
                                      : box!.get('sendNotification'),
                                )),
                        () {},
                      ),
                      settingMenu(
                        "On Duty?",
                        Consumer<SettingProvider>(
                            builder: (context, value, child) => Switch(
                                  activeColor: mainColor,
                                  activeTrackColor: mainColor,
                                  inactiveTrackColor: Colors.orange,
                                  onChanged: (bool bool) async {
                                    provider.onDuty(bool);
                                    Provider.of<HomeController>(context,
                                            listen: false)
                                        .changeDutyStatus(box!.get('isOnDuty'));
                                  },
                                  value: box!.get('isOnDuty') == null
                                      ? true
                                      : box!.get('isOnDuty'),
                                )),
                        () {},
                      ),
                      settingMenu(
                          "Forgot Password?",
                          Icon(Icons.arrow_forward_ios, color: mainColor),
                          () {}),
                      settingMenu(
                          "Log out",
                          Icon(
                            Icons.logout_rounded,
                            color: mainColor,
                          ), () {
                        logoutDialog(context);
                      }),
                      Spacer(),
                      Text(
                        "${cUser.data.hotelid}",
                        style: TextStyle(fontSize: 16, color: mainColor),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
