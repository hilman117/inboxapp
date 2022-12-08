import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:post/Screens/settings/widget/log_out_dialog.dart';
import 'package:post/Screens/settings/setting_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:post/controller/c_user.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import 'widget/setting_menu.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cUser = Get.put(CUser());
    final provider = Provider.of<SettingProvider>(context, listen: false);
    return Consumer<SettingProvider>(
        builder: (context, value, child) => Scaffold(
              backgroundColor: Colors.white,
              body: ModalProgressHUD(
                inAsyncCall: value.isLoad,
                progressIndicator: CircularProgressIndicator(
                  color: secondary,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.05,
                      ),
                      SettingMenu(
                          callback: () {},
                          menuName: AppLocalizations.of(context)!
                              .doYouWantToAcceptNotificationWhenYourRequestAreAccepted,
                          widget: Consumer<SettingProvider>(
                              builder: (context, value, child) =>
                                  Switch.adaptive(
                                    activeColor: mainColor,
                                    activeTrackColor: mainColor,
                                    inactiveTrackColor: Colors.orange,
                                    onChanged: (bool bool) async {
                                      await provider.accepted(bool);
                                    },
                                    value: box!.get(
                                                'ReceiveNotifWhenAccepted') ==
                                            null
                                        ? true
                                        : box!.get('ReceiveNotifWhenAccepted'),
                                  ))),
                      SettingMenu(
                          callback: () {},
                          menuName: AppLocalizations.of(context)!
                              .doYouWantToAcceptNotificationWhenYourRequestAreClose,
                          widget: Consumer<SettingProvider>(
                              builder: (context, value, child) =>
                                  Switch.adaptive(
                                    activeColor: mainColor,
                                    activeTrackColor: mainColor,
                                    inactiveTrackColor: Colors.orange,
                                    onChanged: (bool bool) {
                                      provider.close(bool);
                                    },
                                    value: box!.get('ReceiveNotifWhenClose') ==
                                            null
                                        ? true
                                        : box!.get('ReceiveNotifWhenClose'),
                                  ))),
                      SettingMenu(
                          callback: () {},
                          menuName: AppLocalizations.of(context)!
                              .doYouWantToSendNotificationWhenYouUpdateChat,
                          widget: Consumer<SettingProvider>(
                              builder: (context, value, child) =>
                                  Switch.adaptive(
                                    activeColor: mainColor,
                                    activeTrackColor: mainColor,
                                    inactiveTrackColor: Colors.orange,
                                    onChanged: (bool bool) {
                                      provider.sendNotif(bool);
                                    },
                                    value: box!.get('sendNotification'),
                                  ))),
                      SettingMenu(
                          callback: () {},
                          menuName: "${AppLocalizations.of(context)!.onDuty}?",
                          widget: Consumer<SettingProvider>(
                              builder: (context, val, child) => Switch.adaptive(
                                    activeColor: mainColor,
                                    activeTrackColor: mainColor,
                                    inactiveTrackColor: Colors.orange,
                                    onChanged: (bool bool) async {
                                      provider.onDuty(bool);
                                      Provider.of<SettingProvider>(context,
                                              listen: false)
                                          .changeDutyStatus(bool);
                                    },
                                    value: box!.get('isOnDuty') == null
                                        ? value.getValue
                                        : box!.get('isOnDuty'),
                                  ))),
                      SettingMenu(
                          callback: () {},
                          menuName:
                              AppLocalizations.of(context)!.changePassword,
                          widget:
                              Icon(Icons.arrow_forward_ios, color: mainColor)),
                      SettingMenu(
                          callback: () {
                            logoutDialog(context);
                          },
                          menuName: AppLocalizations.of(context)!.logOut,
                          widget: Icon(
                            Icons.logout_rounded,
                            color: mainColor,
                          )),
                      Spacer(),
                      Text(
                        "${cUser.data.hotelid}",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
