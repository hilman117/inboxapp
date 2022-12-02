import 'package:flutter/material.dart';
import 'package:get/get.dart';

ScrollController scroll = ScrollController();

void bottomSheetComment(BuildContext context) async {
  showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(30))),
      context: context,
      builder: (context) => ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: 10,
          itemBuilder: (context, index) => ListComment()));
}

class ListComment extends StatelessWidget {
  const ListComment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                "https://expertphotography.b-cdn.net/wp-content/uploads/2020/08/social-media-profile-photos-3.jpg"),
          ),
          SizedBox(
            width: Get.width * 0.02,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Donald Rice",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 2),
                      child: CircleAvatar(
                        radius: 1.5,
                        backgroundColor: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Text("15 min ago"),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.005,
              ),
              Container(
                width: Get.width * 0.78,
                child: Text(
                  "kjhdf ksdj fjhs jhf fs sdfjh skdhf ksjdhf ksjdhf kj dfsk skjdhf sdkjf ",
                  overflow: TextOverflow.clip,
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Container(
                child: Row(
                  children: [
                    Text(
                      "Reply",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      width: Get.width * 0.1,
                    ),
                    Text(
                      "Like?",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
