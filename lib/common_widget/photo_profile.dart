import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:post/Screens/settings/setting_provider.dart';
import 'package:provider/provider.dart';

class PhotoProfile extends StatelessWidget {
  final String urlImage;
  final double lebar;
  final double tinggi;
  final double radius;
  const PhotoProfile(
      {super.key,
      required this.lebar,
      required this.tinggi,
      required this.radius,
      required this.urlImage});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
        builder: (context, value, child) => CircleAvatar(
            backgroundColor: Colors.grey,
            radius: radius,
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(50),
              child: urlImage != ''
                  ? LayoutBuilder(
                      builder: (p0, p1) => Image.network(
                            urlImage,
                            fit: BoxFit.cover,
                            width: p1.maxWidth * 1,
                            height: p1.maxHeight * 1,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Container(
                                  width: p1.maxWidth * 1,
                                  height: p1.maxHeight * 1,
                                  color: Colors.grey,
                                  child: Lottie.asset("images/loadimage.json",
                                      width: p1.maxWidth * 1),
                                );
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              print("ini error nya $error");
                              return Image.asset(
                                'images/nophoto.png',
                                fit: BoxFit.cover,
                                // width: width * 0.2,
                              );
                            },
                          ))
                  : LayoutBuilder(builder: (p0, p1) {
                      return Image.asset(
                        'images/nophoto.png',
                        fit: BoxFit.cover,
                        width: p1.maxWidth * 1,
                        height: p1.maxHeight * 1,
                      );
                    }),
            )));
  }
}
