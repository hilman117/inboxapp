import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:post/Screens/settings/setting_provider.dart';
import 'package:provider/provider.dart';

import 'card.dart';

class PhotoProfile extends StatelessWidget {
  final double lebar;
  final double tinggi;
  const PhotoProfile({super.key, required this.lebar, required this.tinggi});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
        builder: (context, value, child) => ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                  width: lebar,
                  height: tinggi,
                  decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(50),
                      shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(300),
                    child: value.imageUrl != ''
                        ? Image.network(
                            value.imageUrl,
                            fit: BoxFit.cover,
                            // width: width * 0.2,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Container(
                                  color: Colors.grey,
                                  child: Lottie.asset("images/loadimage.json",
                                      width: width * 0.2),
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
                          )
                        : Image.asset(
                            'images/nophoto.png',
                            fit: BoxFit.cover,
                            // width: width * 0.2,
                          ),
                  )),
            ));
  }
}
