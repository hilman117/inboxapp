import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post/Screens/chatroom/chatroom_controller.dart';
import 'package:post/Screens/create/widget/general_form.dart';
import 'package:provider/provider.dart';

Future imagePicker(BuildContext context, double height, double widht) {
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
                    icon: const Icon(Icons.camera, color: Colors.orange),
                    label: const Text(
                      "Pick from camera",
                      style: const TextStyle(color: Colors.orange),
                    ),
                    style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.orange,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Provider.of<ChatRoomController>(context, listen: false)
                          .selectImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  height: height * 0.055,
                  width: widht * 0.7,
                  child: OutlinedButton.icon(
                    icon: Icon(Icons.image, color: Colors.orange),
                    label: const Text(
                      "Pick from galery",
                      style: const TextStyle(color: Colors.orange),
                    ),
                    style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.orange,
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
