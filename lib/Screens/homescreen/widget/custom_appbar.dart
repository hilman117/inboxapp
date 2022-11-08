import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:post/Screens/dasboard/widget/card.dart';
import 'package:post/Screens/settings/setting_provider.dart';
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
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
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey),
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
              onTap: () =>
                  Get.to(() => Settings(), transition: Transition.rightToLeft),
              child: Consumer<SettingProvider>(
                builder: (context, value, child) => CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(box!.get('fotoProfile') == ''
                        ? 'https://scontent.fcgk27-1.fna.fbcdn.net/v/t39.30808-6/314984197_5217827161655012_8963512146921511629_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=730e14&_nc_eui2=AeF937McIYSdTVi3_HoAAHOf9YToegKuJSf1hOh6Aq4lJ-TRMK8gevR9UQqjUG6tSX_gzDf107wjEC3d0441twh0&_nc_ohc=OJUCMD0cz8sAX929JAg&_nc_ht=scontent.fcgk27-1.fna&oh=00_AfAql1vtroWjeyiDoxvjyCe07Ajttnv48E7Z1OwCJyK8wQ&oe=636F4993'
                        : box!.get('fotoProfile'))),
              ),
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
