import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../service/theme.dart';
import 'icon_settings.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({required this.dept});
  final String dept;

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      Tab(
        child: Text("My Post",
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.normal)),
      ),
      Tab(
        child: Text(dept,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.normal)),
      ),
      Tab(
        child: Text("Other",
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.normal)),
      ),
      Tab(
        child: Text("Close",
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'images/inbox.png',
              width: Get.width * 0.3,
            ),
            IconSettings()
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
          decoration: BoxDecoration(color: mainColor),
        ),
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 3,
                        offset: Offset(0.5, 0.2), // Shadow position
                      ),
                    ]),
                height: Get.height * 0.050,
                child: TabBar(
                    labelPadding: EdgeInsets.all(0),
                    // isScrollable: true,
                    labelColor: mainColor,
                    indicatorColor: Colors.transparent,
                    unselectedLabelColor:
                        const Color.fromARGB(255, 164, 163, 163),
                    tabs: tabs),
              ),
            ),
            preferredSize: Size.fromHeight(Get.height * 0.050)));
  }
}
