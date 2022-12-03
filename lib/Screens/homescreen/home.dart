import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/create/create_request_controller.dart';
import 'package:post/Screens/homescreen/home_controller.dart';
import 'package:post/Screens/settings/setting_provider.dart';
import 'package:post/controller/c_user.dart';
import 'package:post/models/tasks.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../service/session_user.dart';
import 'widget/add_button.dart';
import 'widget/navbar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

bool image = true;

class _HomeState extends State<Home> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  final cUser = Get.put(CUser());
  final taskModel = Get.put(TaskModel());

  UserDetails? userDetails;
  // String? _getFoto;

  Future getUser() async {
    userDetails = await SessionsUser.getUser();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUser();
    Provider.of<SettingProvider>(context, listen: false).getOnDutyValue();
    Provider.of<CreateRequestController>(context, listen: false)
        .getTotalCreate();
  }

  // @override
  // void dispose() {
  //   AwesomeNotifications().actionSink.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
          extendBody: true,
          bottomNavigationBar: NavBar(),
          floatingActionButton: Consumer<HomeController>(
            builder: (context, value, child) =>
                value.navIndex == 0 || value.navIndex == 2
                    ? addButton(context, Get.height, Get.width)
                    : SizedBox(),
          ),
          backgroundColor: Colors.white,
          body: Provider.of<HomeController>(context)
              .pages[context.read<HomeController>().navIndex]),
    );
  }
}
