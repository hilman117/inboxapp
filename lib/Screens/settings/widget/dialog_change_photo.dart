import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post/Screens/settings/setting_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../service/theme.dart';
import '../../dasboard/widget/card.dart';

Future imagePickerProfile(BuildContext context) {
  return showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      context: context,
      builder: (context) => Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            ),
            height: Get.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: Get.width * 0.07,
                    height: height * 0.005,
                    decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(2)),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.055,
                  width: Get.width * 0.7,
                  child: OutlinedButton.icon(
                    icon: Icon(Icons.camera, color: mainColor),
                    label: Text(
                      AppLocalizations.of(context)!.camera,
                      style: TextStyle(color: mainColor),
                    ),
                    style: OutlinedButton.styleFrom(
                        foregroundColor: cardColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Provider.of<SettingProvider>(context,
                              listen: false)
                          .selectImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.055,
                  width: Get.width * 0.7,
                  child: OutlinedButton.icon(
                    icon: Icon(Icons.image, color: mainColor),
                    label: Text(
                       AppLocalizations.of(context)!.fromGalery,
                      style: TextStyle(color: mainColor),
                    ),
                    style: OutlinedButton.styleFrom(
                        foregroundColor: cardColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Provider.of<SettingProvider>(context,
                              listen: false)
                          .selectImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ));
}
