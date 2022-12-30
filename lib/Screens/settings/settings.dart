import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/common_widget/card.dart';

import 'package:post/Screens/settings/widget/log_out_dialog.dart';
import 'package:post/Screens/settings/setting_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:post/Screens/settings/widget/profile_user.dart';
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
    return Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<SettingProvider>(
          builder: (context, value, child) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: ListView(
              children: [
                SizedBox(
                  height: Get.height * 0.05,
                ),
                ProfileUser(),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                SettingMenu(
                    callback: () {},
                    menuName: AppLocalizations.of(context)!
                        .doYouWantToAcceptNotificationWhenYourRequestAreAccepted,
                    widget: Switch.adaptive(
                      activeColor: mainColor,
                      activeTrackColor: mainColor,
                      inactiveTrackColor: Colors.orange,
                      onChanged: (bool bool) async {
                        await provider.accepted(bool);
                      },
                      value: box!.get('ReceiveNotifWhenAccepted') == null
                          ? true
                          : box!.get('ReceiveNotifWhenAccepted'),
                    )),
                Divider(),
                SettingMenu(
                    callback: () {},
                    menuName: AppLocalizations.of(context)!
                        .doYouWantToAcceptNotificationWhenYourRequestAreClose,
                    widget: Switch.adaptive(
                      activeColor: mainColor,
                      activeTrackColor: mainColor,
                      inactiveTrackColor: Colors.orange,
                      onChanged: (bool bool) {
                        provider.close(bool);
                      },
                      value: box!.get('ReceiveNotifWhenClose') == null
                          ? true
                          : box!.get('ReceiveNotifWhenClose'),
                    )),
                Divider(),
                SettingMenu(
                    callback: () {},
                    menuName: AppLocalizations.of(context)!
                        .doYouWantToSendNotificationWhenYouUpdateChat,
                    widget: Switch.adaptive(
                      activeColor: mainColor,
                      activeTrackColor: mainColor,
                      inactiveTrackColor: Colors.orange,
                      onChanged: (bool bool) {
                        provider.sendNotif(bool);
                      },
                      value: box!.get('sendNotification'),
                    )),
                Divider(),
                SettingMenu(
                    callback: () {},
                    menuName: "${AppLocalizations.of(context)!.onDuty}?",
                    widget: Switch.adaptive(
                      activeColor: mainColor,
                      activeTrackColor: mainColor,
                      inactiveTrackColor: Colors.orange,
                      onChanged: (bool bool) async {
                        provider.onDuty(bool);
                        Provider.of<SettingProvider>(context, listen: false)
                            .changeDutyStatus(bool);
                      },
                      value: box!.get('isOnDuty') == null
                          ? value.getValue
                          : box!.get('isOnDuty'),
                    )),
                Divider(),
                SettingMenu(
                    callback: () {},
                    menuName: AppLocalizations.of(context)!.changePassword,
                    widget: Icon(Icons.arrow_forward_ios, color: mainColor)),
                Divider(),
                SettingMenu(
                    callback: () {
                      logoutDialog(context);
                    },
                    menuName: AppLocalizations.of(context)!.logOut,
                    widget: Icon(
                      Icons.logout_rounded,
                      color: mainColor,
                    )),
                Divider(),
                SizedBox(
                  height: height * 0.03,
                ),
                Center(
                  child: Text(
                    "${cUser.data.hotelid}",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
