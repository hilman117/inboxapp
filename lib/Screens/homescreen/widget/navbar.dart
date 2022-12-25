import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/create/create_request.dart';
import 'package:post/Screens/homescreen/home_controller.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';

import '../../chatroom/widget/pop_up_menu/pop_up_menu_provider.dart';
import '../../create/create_request_controller.dart';
import '../../dasboard/widget/card.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
        builder: (context, value, child) => BottomNavigationBar(
                selectedIconTheme: IconThemeData(color: mainColor),
                unselectedIconTheme: IconThemeData(color: Colors.grey),
                onTap: (int val) async {
                  if (val == 1) {
                    Provider.of<PopUpMenuProvider>(context, listen: false)
                        .isChangeTitle(false);
                    Provider.of<CreateRequestController>(context, listen: false)
                        .clearData();
                    Provider.of<CreateRequestController>(context, listen: false)
                        .clearSchedule();
                    Provider.of<CreateRequestController>(context, listen: false)
                        .getLocation(cUser.data.hotelid!);
                    Provider.of<CreateRequestController>(context, listen: false)
                        .getDeptartement();
                    await Get.to(() => CreateRequest(),
                        transition: Transition.rightToLeft);
                  } else {
                    Provider.of<HomeController>(context, listen: false)
                        .changePage(val);
                    print(value.navIndex);
                  }
                },
                currentIndex: value.navIndex,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.checklist_rounded,
                      ),
                      label: AppLocalizations.of(context)!.request),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.add,
                      ),
                      label: "Create"),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.not_listed_location_rounded,
                      ),
                      label: "Lost And Found"),
                ]));
    //  Container(
    //     height: Get.height * 0.11,
    //     alignment: Alignment.bottomCenter,
    //     child: Consumer<HomeController>(
    //         builder: (context, value, child) => FloatingNavbar(
    //               // elevation: 50.0,
    //               width: Get.width * 0.85,
    //               backgroundColor: Colors.white54,
    //               borderRadius: 15,
    //               currentIndex: value.navIndex,
    //               onTap: (int val) {
    //                 Provider.of<HomeController>(context, listen: false)
    //                     .changePage(val);
    //                 print(value.navIndex);
    //               },
    //               elevation: 60,
    //               unselectedItemColor: Colors.grey,
    //               selectedBackgroundColor: Colors.white,
    //               selectedItemColor: mainColor,
    //               items: [
    //                 FloatingNavbarItem(
    //                   icon: Icons.checklist_rounded,
    //                   title: AppLocalizations.of(context)!.request,
    //                 ),
    //                 FloatingNavbarItem(icon: Icons.home_rounded, title: 'Home'),
    //                 FloatingNavbarItem(
    //                     icon: Icons.not_listed_location_rounded,
    //                     title: 'Lost and Found'),
    //               ],
    //             )));
  }
}
