import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:post/Screens/dasboard/widget/card.dart';
import 'package:post/Screens/settings/setting_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../settings/settings.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width * 0.45,
              child: Text(
                cUser.data.hotel!,
                style: TextStyle(color: Colors.black87, fontSize: 16),
                overflow: TextOverflow.clip,
              ),
            ),
            Spacer(),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Consumer<HomeController>(
                            builder: (context, value, child) => CircleAvatar(
                                radius: 3,
                                backgroundColor: box!.get('dutyStatus') == true
                                    ? mainColor
                                    : Colors.grey)),
                        SizedBox(
                          width: Get.width * 0.01,
                        ),
                        Consumer<HomeController>(
                            builder: (context, value, child) => Text(
                                  box!.get('dutyStatus') == true
                                      ? "On Duty"
                                      : 'Off Duty',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey),
                                )),
                      ],
                    ),
                    Text(
                      cUser.data.name!,
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.black, fontSize: 13),
                    )
                  ],
                ),
                SizedBox(
                  width: Get.width * 0.02,
                ),
                GestureDetector(
                  onTap: () => Get.to(() => Settings(),
                      transition: Transition.rightToLeft),
                  child: Consumer<SettingProvider>(
                    builder: (context, value, child) => CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(value.imageUrl)),
                  ),
                ),
              ],
            )
          ],
        ),
        elevation: 0,
        pinned: true,
        snap: true,
        floating: true,
        expandedHeight: Get.height * 0.12,
        flexibleSpace: Container(
          height: double.maxFinite,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
        ),
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.white,
                ),
                height: Get.height * 0.050,
                child: TabBar(
                    labelPadding: EdgeInsets.all(0),
                    labelColor: mainColor,
                    indicatorColor: Colors.transparent,
                    unselectedLabelColor: Colors.grey,
                    tabs: tabs),
              ),
            ),
            preferredSize: Size.fromHeight(Get.height * 0.050)));
  }
}
