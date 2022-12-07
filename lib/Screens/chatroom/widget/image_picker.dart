import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post/Screens/chatroom/chatroom_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:post/Screens/create/widget/general_form.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';

Future imagePicker(BuildContext context, double height, double widht) {
  final app = AppLocalizations.of(context);
  return showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      context: context,
      builder: (context) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            ),
            height: height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: widht * 0.07,
                    height: height * 0.005,
                    decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(2)),
                  ),
                ),
                SizedBox(
                  height: height * 0.055,
                  width: widht * 0.7,
                  child: OutlinedButton.icon(
                    icon: Icon(Icons.camera, color: mainColor),
                    label: Text(
                      app!.camera,
                      style: TextStyle(color: mainColor),
                    ),
                    style: OutlinedButton.styleFrom(
                        foregroundColor: mainColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Provider.of<ChatRoomController>(context, listen: false)
                          .selectFromCamera();
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  height: height * 0.055,
                  width: widht * 0.7,
                  child: OutlinedButton.icon(
                    icon: Icon(Icons.image, color: mainColor),
                    label: Text(
                      app.fromGalery,
                      style: TextStyle(color: mainColor),
                    ),
                    style: OutlinedButton.styleFrom(
                        foregroundColor: mainColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Provider.of<ChatRoomController>(context, listen: false)
                          .selectImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ));
}
