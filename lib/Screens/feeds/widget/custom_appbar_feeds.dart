import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:post/Screens/feeds/widget/search.dart';
import 'package:post/Screens/profile/profile.dart';
import 'package:post/Screens/settings/setting_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';

import '../../homescreen/home_controller.dart';

class CustomAppbarFeeds extends StatelessWidget {
  const CustomAppbarFeeds({required this.dept});
  final String dept;

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      Tab(
        child: Text(AppLocalizations.of(context)!.myPost,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.normal)),
      ),
      Tab(
        child: Text(dept,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.normal)),
      ),
      Tab(
        child: Text(AppLocalizations.of(context)!.others,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.normal)),
      ),
      Tab(
        child: Text(AppLocalizations.of(context)!.closed,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.normal)),
      ),
    ];
    return SliverAppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        title: Row(
          children: [
            Consumer<HomeController>(
              builder: (context, value, child) => GestureDetector(
                  onTap: () async {
                    Get.to(() => ProfileWidget(),
                        transition: Transition.rightToLeft);
                  },
                  child: Consumer<SettingProvider>(
                      builder: (context, value, child) => Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 20,
                                    child: value.imageUrl != ''
                                        ? Image.network(
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              } else {
                                                return Image.asset(
                                                  'images/nophoto.png',
                                                  fit: BoxFit.cover,
                                                );
                                              }
                                            },
                                            value.imageUrl,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'images/nophoto.png',
                                            fit: BoxFit.cover,
                                          ),
                                  )),
                              Positioned(
                                bottom: 6,
                                right: 4,
                                child: CircleAvatar(
                                    radius: 4,
                                    backgroundColor: value.getValue == true
                                        ? Color(0xff05B714)
                                        : Colors.red.shade500),
                              )
                            ],
                          ))),
            ),
            SizedBox(
              width: Get.width * 0.02,
            ),
            Search(),
            Container(
              margin: EdgeInsets.only(left: Get.width * 0.03),
              height: Get.height * 0.06,
              child: Icon(
                Icons.notifications,
                color: Colors.grey,
                size: 30,
              ),
            )
          ],
        ),
        elevation: 0,
        pinned: true,
        snap: true,
        floating: true,
        expandedHeight: Get.height * 0.07,
        flexibleSpace: Container(
          height: double.maxFinite,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
        ),
        bottom: PreferredSize(
            child:
                Provider.of<HomeController>(context, listen: false).navIndex ==
                        0
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.white,
                          ),
                          height: Get.height * 0.40,
                          child: TabBar(
                              labelPadding: EdgeInsets.all(0),
                              labelColor: mainColor,
                              indicatorColor: Colors.transparent,
                              unselectedLabelColor: Colors.grey,
                              tabs: tabs),
                        ),
                      )
                    : SizedBox(),
            preferredSize: Size.fromHeight(Get.height * 0.00)));
  }
}
