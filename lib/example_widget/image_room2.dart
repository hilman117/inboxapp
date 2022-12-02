import 'package:flutter/material.dart';

class ImageRoom2 extends StatelessWidget {
  final String image;
  final String tag;
  const ImageRoom2({super.key, required this.image, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(tag: "imageHero", child: Image.network(image)),
        ),
      ),
    );
  }
}
