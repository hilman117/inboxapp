import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/settings/setting_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';

void logoutDialog(context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: Container(
            alignment: Alignment.center,
            height: 90,
            child: Column(
              children: [
                Text(
                  "${AppLocalizations.of(context)!.logOutDialog}?",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: Get.width * 0.2,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(AppLocalizations.of(context)!.no),
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            foregroundColor: mainColor),
                      ),
                    ),
                    // SizedBox(width: 30),
                    SizedBox(
                      width: Get.width * 0.2,
                      child: ElevatedButton(
                        onPressed: () {
                          Provider.of<SettingProvider>(context, listen: false)
                              .signOut(context);
                        },
                        child: Text(AppLocalizations.of(context)!.yes),
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            backgroundColor: mainColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}
