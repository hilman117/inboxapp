import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/feeds/feeds.dart';
import 'package:post/Screens/profile/profiile_controller.dart';
import 'package:post/Screens/settings/settings.dart';
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
    final controller = Provider.of<ProfileController>(context, listen: false);
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
        body: SafeArea(
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
                                                color: Colors.grey.shade200))),
                                    width: width * 0.85,
                                    child: TextField(
                                      controller: controller.typing,
                                      onChanged: (value) {
                                        controller.isUsertyping(value);
                                      },
                                      minLines: 1,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                          hintText:
                                              'What do you want to share?',
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10)),
                                    )),
                                // SizedBox(
                                //   height: height * 0.01,
                                // ),
                                // Container(
                                //   width: width * 0.85,
                                //   height: Get.height * 0.04,
                                //   child: ElevatedButton(
                                //       style: ElevatedButton.styleFrom(
                                //           elevation: 0,
                                //           backgroundColor: mainColor),
                                //       onPressed: () {},
                                //       child: Text("Post")),
                                // )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  right: width * 0.05, top: height * 0.01),
                              child: Image.asset(
                                'images/galery.png',
                                width: Get.width * 0.08,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Replace your ListView.builder with this:
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: 20,
                    (BuildContext context, int index) {
                      return ListFeeds();
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
