import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/create/create_request_controller.dart';
import 'package:post/Screens/homescreen/home_controller.dart';
import 'package:post/Screens/settings/setting_provider.dart';
import 'package:post/controller/c_user.dart';
import 'package:post/core.dart';
import 'package:post/global_function.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
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
  late ScrollController controller;

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
    controller = ScrollController();
    if (box!.get('sendNotification') == null) {
      box!.putAll({'sendNotification': true});
    }
    getUser();
    Provider.of<SettingProvider>(context, listen: false).getOnDutyValue();
    Provider.of<HomeController>(context, listen: false)
        .dataForNotiifcationAction();
    Provider.of<GlobalFunction>(context, listen: false)
        .checkInternetConnetction();
    // Provider.of<HomeController>(context, listen: false).actionStreamNotif();
    Provider.of<CreateRequestController>(context, listen: false)
        .getTotalCreate();
  }

  @override
  void dispose() {
    AwesomeNotifications().actionSink.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: NavBar(),
        backgroundColor: Colors.white,
        body:
            // ListView.builder(
            //     controller: controller,
            //     itemCount: 20,
            //     itemBuilder: (context, index) => ListTile(
            //           title: Text("test"),
            //         ))
            Provider.of<HomeController>(context)
                .pages[context.read<HomeController>().navIndex],
      ),
    );
  }
}
