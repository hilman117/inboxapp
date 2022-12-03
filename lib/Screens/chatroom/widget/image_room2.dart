import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:post/Screens/chatroom/chatroom_controller.dart';
import 'package:post/Screens/dasboard/widget/card.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';

class ImageRoom2 extends StatelessWidget {
  final List<dynamic> imageList;
  final String image;
  final int index;
  final String tag;
  const ImageRoom2(
      {super.key,
      required this.image,
      required this.tag,
      required this.imageList,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            width: width,
            height: height,
            child: CarouselSlider(
                items: List.generate(imageList.length, (index) {
                  return Container(
                    alignment: Alignment.center,
                    height: height,
                    width: width,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Image.network(
                            imageList[index],
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress != null) {
                                return Lottie.asset("images/loadimage.json",
                                    width: 100);
                              } else {
                                return child;
                              }
                            },
                            fit: BoxFit.contain,
                          ),
                        ),
                        Positioned(
                            bottom: 25,
                            right: 25,
                            child: GestureDetector(
                              onTap: () => Provider.of<ChatRoomController>(
                                      context,
                                      listen: false)
                                  .saveNetworkImage(imageList[index]),
                              child: Icon(
                                Icons.download,
                                size: 30,
                                color: mainColor,
                              ),
                            ))
                      ],
                    ),
                  );
                }),
                options: CarouselOptions(
                  viewportFraction: 1,
                  aspectRatio: 640 / 1300,
                  initialPage: index,
                  enableInfiniteScroll: false,
                  reverse: false,
                  autoPlay: false,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                )),
          ),
        ));
  }
}
