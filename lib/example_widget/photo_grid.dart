import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'image_room2.dart';

class PhotoGrid extends StatefulWidget {
  final int maxImages;
  final List<String> imageUrls;
  final Function(int) onImageClicked;
  final Function onExpandClicked;

  PhotoGrid(
      {required this.imageUrls,
      required this.onImageClicked,
      required this.onExpandClicked,
      this.maxImages = 4,
      Key? key})
      : super(key: key);

  @override
  createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  @override
  Widget build(BuildContext context) {
    String uniqueTag = "heroImage" + DateTime.now().toString();
    var images = buildImages(uniqueTag);
    return GridView(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      children: images,
    );
  }

  List<Widget> buildImages(String idTag) {
    int numImages = widget.imageUrls.length;
    return List<Widget>.generate(min(numImages, widget.maxImages), (index) {
      String imageUrl = widget.imageUrls[index];

      // If its the last image
      if (index == widget.maxImages - 1) {
        // Check how many more images are left
        int remaining = numImages - widget.maxImages;

        // If no more are remaining return a simple image widget
        if (remaining == 0) {
          return GestureDetector(
            child: Hero(
              tag: "tag${widget.imageUrls[index].toString()}",
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            onTap: () => Get.to(() => ImageRoom2(image: imageUrl, tag: idTag)),
          );
        } else {
          // Create the facebook like effect for the last image with number of remaining  images
          return GestureDetector(
            onTap: () => Get.to(() => ImageRoom2(image: imageUrl, tag: idTag)),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Hero(
                    tag: "tag${widget.imageUrls[index].toString()}",
                    child: Image.network(imageUrl, fit: BoxFit.cover)),
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black54,
                    child: Text(
                      '+' + remaining.toString(),
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      } else {
        return GestureDetector(
          child: Container(
            child: Hero(
              tag: "tag${widget.imageUrls.length + Random().nextInt(1000)}",
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          onTap: () => Get.to(() => ImageRoom2(image: imageUrl, tag: idTag)),
        );
      }
    });
  }
}
