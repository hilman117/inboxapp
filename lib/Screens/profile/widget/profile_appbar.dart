import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/feeds/feeds_controller.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../../common_widget/card.dart';
import '../../settings/setting_provider.dart';
import '../../settings/widget/dialog_change_photo.dart';

class ProfileAppbar extends StatelessWidget {
  const ProfileAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FeedsController>(context);
    String postId = Uuid().v4();
    return Consumer<SettingProvider>(
      builder: (context, value, child) => Padding(
        padding:
            EdgeInsets.only(left: Get.width * 0.03, top: Get.height * 0.005),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => imagePickerProfile(context),
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: Get.width * 0.16,
                        height: Get.height * 0.076,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)),
                        child: value.imageUrl != ''
                            ? Image.network(
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return Image.asset(
                                      'images/nophoto.png',
                                      fit: BoxFit.cover,
                                    );
                                  }
                                },
                                value.imageUrl,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'images/nophoto.png',
                                fit: BoxFit.cover,
                              ),
                      )),
                  Positioned(
                      left: Get.width * 0.10,
                      top: Get.height * 0.045,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 10,
                        child: Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.black45,
                          size: 15,
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(width: Get.width * 0.02),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: Get.width * 0.60,
                      child: Text(
                        cUser.data.name!,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (provider.istyping ||
                            Provider.of<FeedsController>(context, listen: false)
                                .imagesList
                                .isNotEmpty) {
                          Provider.of<FeedsController>(context, listen: false)
                              .postSomething(
                                  context, provider.typing.text, postId);
                        }
                      },
                      child: Text(
                        "Posting",
                        style: TextStyle(
                            color: provider.istyping ||
                                    Provider.of<FeedsController>(context)
                                        .imagesList
                                        .isNotEmpty
                                ? mainColor
                                : Colors.grey.shade300,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
                SizedBox(height: Get.height * 0.005),
                Text(
                  cUser.data.position!,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: Get.height * 0.005),
                Text(
                  cUser.data.email!,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
