import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/dasboard/dashboard_provider.dart';
import 'package:post/Screens/homescreen/home_controller.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';

import 'add_button.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: Get.height * 0.11,
            alignment: Alignment.bottomCenter,
            child: Consumer<HomeController>(
                builder: (context, value, child) => FloatingNavbar(

                      // elevation: 50.0,
                      width: Get.width * 0.85,
                      backgroundColor: Colors.white54,
                      borderRadius: 15,
                      currentIndex: value.navIndex,
                      onTap: (int val) {
                        Provider.of<HomeController>(context, listen: false)
                            .changePage(val);
                        print(value.navIndex);
                      },
                      elevation: 60,
                      unselectedItemColor: Colors.grey,
                      selectedBackgroundColor: Colors.white,
                      selectedItemColor: mainColor,
                      items: [
                        FloatingNavbarItem(
                          icon: Icons.checklist_rounded,
                          title: 'Request',
                        ),
                        FloatingNavbarItem(
                            icon: Icons.not_listed_location_rounded,
                            title: 'Lost and Found'),
                      ],
                    ))),
        Positioned(
            left: Get.width * 0.42,
            bottom: Get.height * 0.035,
            child: addButton(context, Get.height, Get.width)),
        Provider.of<DashboardProvider>(context).list.length >= 1
            ? Positioned(
                top: Get.height * 0.025,
                left: Get.width * 0.23,
                child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: Get.width * 0.03,
                    child: Consumer<DashboardProvider>(
                        builder: (context, value, child) => Text(
                              "${value.list.length}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ))),
              )
            : SizedBox()
      ],
    );
  }
}
