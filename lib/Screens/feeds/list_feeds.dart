import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/feeds/widget/bottom_sheet_comment.dart';
import 'package:post/models/feeds_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import '../../service/theme.dart';
import '../chatroom/widget/multiple_photos.dart';
import '../dasboard/widget/card.dart';
import '../dasboard/widget/timer.dart';
import 'widget/custom_appbar_feeds.dart';

class Feeds extends StatelessWidget {
  const Feeds({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: NestedScrollView(
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
          borderRadius: BorderRadius.circular(6), color: Colors.white),
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
              Text(remainingDateTime(context, feedsmodel.thisPostCeatedAt!),
                  style: TextStyle(color: Colors.grey))
            ],
          ),
          Container(
            width: width,
            child: Text(feedsmodel.postStuff!),
          ),
          feedsmodel.images!.isNotEmpty
              ? Container(
                  // width: width,
                  height: feedsmodel.images!.length <= 2
                      ? height * 0.23
                      : height * 0.45,
                  child: MultiplePhoto(
                    images: feedsmodel.images!,
                    moreThan4: Get.width * 0.6,
                    isEqualorLessThan1: width * 12,
                  ),
                )
              : SizedBox(),
          SizedBox(height: height * 0.015),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CupertinoIcons.hand_thumbsup_fill,
                    size: 13,
                    color: mainColor,
                  ),
                  SizedBox(
                    width: width * 0.007,
                  ),
                  Text(
                    "(Hsk) Jhon Doe and 34 others",
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
              Text(
                feedsmodel.comment!.length < 1
                    ? "5 comments"
                    : feedsmodel.comment!.length.toString(),
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Icon(
                      CupertinoIcons.hand_thumbsup,
                      color: Colors.grey,
                    ),
                    Text(
                      "like",
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    )
                  ],
                ),
                SizedBox(width: width * 0.015),
                InkWell(
                  onTap: () => bottomSheetComment(context),
                  child: Column(
                    children: [
                      Icon(
                        CupertinoIcons.chat_bubble_2,
                        color: Colors.grey,
                      ),
                      Text(
                        "comment",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      )
                    ],
                  ),
                ),
                SizedBox(width: width * 0.015),
                Column(
                  children: [
                    Icon(
                      Icons.send_outlined,
                      color: Colors.grey,
                    ),
                    Text(
                      "share",
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
