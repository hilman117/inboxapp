import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/feeds/widget/bottom_sheet_comment.dart';
import 'package:post/models/feeds_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import '../chatroom/widget/multiple_photos.dart';
import '../dasboard/widget/card.dart';
import 'widget/custom_appbar_feeds.dart';

class Feeds extends StatelessWidget {
  const Feeds({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        Consumer(
          builder: (context, value, child) =>
              CustomAppbarFeeds(dept: cUser.data.department ?? ''),
        )
      ],
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Hotel List')
            .doc(cUser.data.hotelid)
            .collection('feeds')
            .snapshots(includeMetadataChanges: true),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.docs.isEmpty) {
            return SizedBox();
          }
          List<QueryDocumentSnapshot<Object?>> list = snapshot.data!.docs;
          print(list);
          return ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(0),
              itemCount: list.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data =
                    list[index].data()! as Map<String, dynamic>;
                FeedsModel feedsModel = FeedsModel.fromJson(data);
                print(data);
                return FeedsCard(feedsmodel: feedsModel);
              });
        },
      ),
    );
  }
}

class FeedsCard extends StatelessWidget {
  final FeedsModel feedsmodel;
  const FeedsCard({super.key, required this.feedsmodel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.grey.shade100),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //widget foto
              CircleAvatar(
                radius: Get.width * 0.06,
                backgroundImage: NetworkImage(feedsmodel.imagePostSender!),
              ),
              SizedBox(
                width: Get.width * 0.02,
              ),
              //widget nama dan posisi
              Container(
                height: height * 0.06,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feedsmodel.name!,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      feedsmodel.position!,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Spacer(),
              //widget waktu
              Text("2hrs ago", style: TextStyle(color: Colors.grey))
            ],
          ),
          Container(
            width: width,
            child: Text(feedsmodel.postStuff!),
          ),
          SizedBox(height: height * 0.015),
          feedsmodel.images!.isNotEmpty
              ? Container(
                  // width: width,
                  height: height * 0.2,
                  child: MultiplePhoto(images: feedsmodel.images!),
                )
              : SizedBox(),
          SizedBox(height: height * 0.015),
          GestureDetector(
            onTap: () => bottomSheetComment(context),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.chat_bubble_2,
                  color: Colors.grey,
                ),
                SizedBox(width: width * 0.015),
                Text(
                  feedsmodel.comment!.length.toString(),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
