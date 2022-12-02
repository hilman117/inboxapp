import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/feeds/widget/bottom_sheet_comment.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
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
      body: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(0),
          itemCount: 10,
          itemBuilder: (context, index) => ListFeeds()),
    );
  }
}

class ListFeeds extends StatelessWidget {
  const ListFeeds({super.key});

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
                backgroundImage: NetworkImage(
                    'https://expertphotography.b-cdn.net/wp-content/uploads/2020/08/social-media-profile-photos-3.jpg'),
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
                      "(HSK) William Henderson",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Housekeeping Attendant",
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
            child: Text(
                "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available. Wikipedia"),
          ),
          SizedBox(height: height * 0.015),
          Container(
            width: width,
            height: height * 0.2,
            child: Image.network(
              "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg",
              fit: BoxFit.cover,
            ),
          ),
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
                  "12",
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
