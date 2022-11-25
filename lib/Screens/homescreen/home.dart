import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/create/create_request_controller.dart';
import 'package:post/Screens/homescreen/home_controller.dart';
import 'package:post/controller/c_user.dart';
import 'package:post/models/tasks.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../service/session_user.dart';
import '../chatroom/chatroom_controller.dart';
import 'widget/navbar.dart';
import 'widget/search.dart';

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

  void getUser() async {
    userDetails = await SessionsUser.getUser();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // Provider.of<HomeController>(context, listen: false)
    //     .dataForNotiifcationAction();
    // Provider.of<HomeController>(context, listen: false).actionStreamNotif();
    getUser();
    Provider.of<CreateRequestController>(context, listen: false)
        .getTotalCreate();
    Provider.of<ChatRoomController>(context, listen: false)
        .getTotalAcceptedAndClose();
    Provider.of<HomeController>(context, listen: false)
        .getPhotoProfile(context);
    Provider.of<CreateRequestController>(context, listen: false)
        .getDeptartement(cUser.data.hotelid!);
    Provider.of<CreateRequestController>(context, listen: false)
        .getLocation(cUser.data.hotelid!);
    // print(
    //     " data of assignmenrt stuff ${Provider.of<HomeController>(context, listen: false).data}");
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
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Consumer<HomeController>(
            builder: (context, value, child) => searchButton(context),
          ),
          backgroundColor: Colors.white,
          body: Provider.of<HomeController>(context)
              .pages[context.read<HomeController>().navIndex]),
    );
  }
}
