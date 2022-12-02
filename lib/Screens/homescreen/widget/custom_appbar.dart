import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:post/Screens/dasboard/widget/card.dart';
import 'package:post/Screens/profile/profile.dart';
import 'package:post/Screens/settings/setting_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';

import '../home_controller.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({required this.dept});
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
                      builder: (context, value, child) => ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            width: Get.width * 0.145,
                            height: Get.height * 0.065,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)),
                            child: value.imageUrl != ''
                                ? Image.network(
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
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
                          )))),
            ),
            SizedBox(
              width: Get.width * 0.02,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // width: Get.width * 0.45,
                  child: Text(
                    cUser.data.hotel!,
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                    overflow: TextOverflow.clip,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.005,
                ),
                Container(
                  width: Get.width * 0.33,
                  child: Text(
                    cUser.data.name!,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(color: Colors.black, fontSize: 13),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.005,
                ),
                Row(
                  children: [
                    Consumer<SettingProvider>(
                        builder: (context, value, child) => CircleAvatar(
                            radius: 3,
                            backgroundColor: value.getValue == true
                                ? mainColor
                                : Colors.grey)),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    Consumer<SettingProvider>(
                        builder: (context, value, child) => Text(
                              value.getValue == true
                                  ? AppLocalizations.of(context)!.onDuty
                                  : AppLocalizations.of(context)!.offDuty,
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey),
                            )),
                  ],
                ),
              ],
            ),
          ],
        ),
        elevation: 0,
        pinned: true,
        snap: true,
        floating: true,
        expandedHeight:
            Provider.of<HomeController>(context, listen: false).navIndex == 0
                ? Get.height * 0.12
                : Get.height * 0.08,
        flexibleSpace: Container(
          height: double.maxFinite,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
        ),
        bottom: PreferredSize(
            child: Provider.of<HomeController>(context, listen: false)
                        .navIndex ==
                    0
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.white,
                      ),
                      height:
                          Provider.of<HomeController>(context, listen: false)
                                      .navIndex ==
                                  0
                              ? Get.height * 0.050
                              : Get.height * 0.40,
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
                Provider.of<HomeController>(context, listen: false).navIndex ==
                        0
                    ? Get.height * 0.050
                    : Get.height * 0.00)));
  }
}
