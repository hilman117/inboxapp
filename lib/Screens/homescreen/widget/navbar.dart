import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/homescreen/home_controller.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      title: AppLocalizations.of(context)!.request,
                    ),
                    FloatingNavbarItem(icon: Icons.home_rounded, title: 'Home'),
                    FloatingNavbarItem(
                        icon: Icons.not_listed_location_rounded,
                        title: 'Lost and Found'),
                  ],
                )));
  }
}
