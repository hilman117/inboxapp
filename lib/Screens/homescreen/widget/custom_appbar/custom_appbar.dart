import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:post/Screens/settings/setting_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:post/common_widget/photo_profile.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';

import '../../../settings/settings.dart';
import '../../home_controller.dart';
import 'widget/search_home.dart';

class CustomAppbarHome extends StatelessWidget {
  const CustomAppbarHome({required this.dept});
  final String dept;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer<SettingProvider>(
                builder: (context, val, child) => Stack(
                      children: [
                        PhotoProfile(
                          lebar: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? size.width * 0.06
                              : size.width * 0.10,
                          tinggi: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? size.height * 0.11
                              : size.height * 0.055,
                          radius: 20,
                          urlImage: val.imageUrl,
                        ),
                        Positioned(
                          bottom: 4,
                          right: 2,
                          child: CircleAvatar(
                              radius: 4,
                              backgroundColor: val.getValue == true
                                  ? Color(0xff05B714)
                                  : Colors.red.shade500),
                        )
                      ],
                    )),
            SizedBox(
              width: Get.width * 0.02,
            ),
            SearchHome(),
            GestureDetector(
              onTap: () {
                Get.to(() => Settings(), transition: Transition.rightToLeft);
              },
              child: Container(
                  margin: EdgeInsets.only(left: Get.width * 0.04),
                  height: Get.height * 0.06,
                  child: Icon(
                    Icons.settings,
                    color: Colors.black45,
                  )),
            ),
          ],
        ),
        elevation: 0,
        pinned: true,
        snap: true,
        floating: true,
        expandedHeight:
            MediaQuery.of(context).orientation == Orientation.landscape
                ? Get.height * 0.2
                : Get.height * 0.13,
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
                          height: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? Get.height * 0.070
                              : Get.height * 0.050,
                          child: TabBar(
                              labelPadding: EdgeInsets.all(0),
                              labelColor: mainColor,
                              indicatorColor: Colors.transparent,
                              unselectedLabelColor: Colors.grey,
                              tabs: tabs),
                        ),
                      )
                    : SizedBox(),
            preferredSize: Size.fromHeight(
                MediaQuery.of(context).orientation == Orientation.landscape
                    ? Get.height * 0.070
                    : Get.height * 0.050)));
  }
}
