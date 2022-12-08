import 'package:flutter/material.dart';
import 'package:post/Screens/chatroom/widget/photo_grid.dart';

var urls = <String>[
  'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
  'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
  'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
  'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
  'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
  'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
];

class MultiplePhoto extends StatelessWidget {
  final List<dynamic> images;
  final double moreThan4;
  final double isEqualorLessThan1;
  const MultiplePhoto(
      {super.key,
      required this.images,
      required this.moreThan4,
      required this.isEqualorLessThan1});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PhotoGrid(
        imageUrls: images,
        onImageClicked: (i) => print('Image $i was clicked!'),
        onExpandClicked: () => print('Expand Image was clicked'),
        maxImages: 4,
        key: null,
        moreThan4: moreThan4,
        isEqualorLessThan1: isEqualorLessThan1,
      ),
    );
  }
}
