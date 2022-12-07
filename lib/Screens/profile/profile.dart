import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:post/Screens/feeds/feeds_controller.dart';
import 'package:post/Screens/profile/widget/bottom_sheet_image_picker.dart';
import 'package:post/Screens/profile/widget/list_images_feeds.dart';
import 'package:provider/provider.dart';

import '../../service/theme.dart';
import '../dasboard/widget/card.dart';
import 'widget/profile_appbar.dart';
import 'widget/seach_on_appbar.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final feedsController = Provider.of<FeedsController>(context);
    return Scaffold(
        appBar: AppBar(
          title: SearchOnAppBar(),
          leading: Icon(
            CupertinoIcons.back,
            color: Colors.black54,
          ),
          leadingWidth: size.width * 0.1,
          automaticallyImplyLeading: true,
          elevation: 0.5,
          backgroundColor: Colors.white,
          actions: [
            InkWell(
              radius: 20,
              borderRadius: BorderRadius.circular(50),
              onTap: () =>
                  Get.to(() => Settings(), transition: Transition.rightToLeft),
              child: Material(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    padding: EdgeInsets.only(right: width * 0.05),
                    height: Get.height * 0.07,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.settings,
                      color: mainColor,
                    )),
              ),
            )
          ],
        ),
        body: ModalProgressHUD(
          inAsyncCall: feedsController.isPostInProgress ? true : false,
          progressIndicator: Lottie.asset('images/loadimage.json'),
          child: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    // Put here all widgets that are not slivers.
                    child: Column(
                      children: [
                        ProfileAppbar(),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Container(
                          // color: Colors.blue.shade50,
                          width: width,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                      Colors.grey.shade200))),
                                      width: width * 0.85,
                                      child: TextField(
                                        controller: feedsController.typing,
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            feedsController.isUsertyping(true);
                                          } else {
                                            feedsController.isUsertyping(false);
                                          }
                                        },
                                        minLines: 1,
                                        maxLines: 5,
                                        decoration: InputDecoration(
                                            hintText:
                                                'What do you want to share?',
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10)),
                                      )),
                                ],
                              ),
                              GestureDetector(
                                onTap: () => imagePickerFeeds(context),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: width * 0.05, top: height * 0.01),
                                  child: Image.asset(
                                    'images/galery.png',
                                    width: Get.width * 0.08,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        feedsController.imagesList.isNotEmpty
                            ? ListImagesFeeds()
                            : SizedBox()
                      ],
                    ),
                  ),
                  // Replace your ListView.builder with this:
                  // StreamBuilder(
                  //   stream: FirebaseFirestore.instance
                  //       .collection('Hotel List')
                  //       .doc(cUser.data.hotelid)
                  //       .collection('feeds')
                  //       .where("name", isEqualTo: cUser.data.name)
                  //       .snapshots(includeMetadataChanges: true),
                  //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  //     if (snapshot.hasError) {
                  //       return Center(child: Text('Something went wrong'));
                  //     }
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return Center(child: CircularProgressIndicator());
                  //     }
                  //     if (snapshot.data!.docs.isEmpty) {
                  //       return SizedBox();
                  //     }
                  //     List<QueryDocumentSnapshot<Object?>> list =
                  //         snapshot.data!.docs;
                  //     return SliverList(
                  //       delegate: SliverChildBuilderDelegate(
                  //         childCount: list.length,
                  //         (BuildContext context, int index) {
                  //           Map<String, dynamic> data =
                  //               list[index].data()! as Map<String, dynamic>;
                  //           FeedsModel feedsModel = FeedsModel.fromJson(data);
                  //           return FeedsCard(
                  //             feedsmodel: feedsModel,
                  //           );
                  //         },
                  //       ),
                  //     );
                  //   },
                  // )
                ],
              ),
            ),
          ),
        ));
  }
}
