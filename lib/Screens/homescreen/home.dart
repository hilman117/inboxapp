import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/chatroom/chatroom_controller.dart';
import 'package:post/Screens/create/create_request_controller.dart';
import 'package:post/Screens/homescreen/home_controller.dart';
import 'package:post/controller/c_user.dart';
import 'package:post/models/tasks.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../service/session_user.dart';
import 'widget/navbar.dart';
import 'widget/search.dart';

class Home extends StatefulWidget {
  static String? imageProfile;
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
    Home.imageProfile = cUser.data.profileImage != null
        ? cUser.data.profileImage!
        : 'https://scontent.fcgk27-1.fna.fbcdn.net/v/t39.30808-6/314984197_5217827161655012_8963512146921511629_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=730e14&_nc_eui2=AeF937McIYSdTVi3_HoAAHOf9YToegKuJSf1hOh6Aq4lJ-TRMK8gevR9UQqjUG6tSX_gzDf107wjEC3d0441twh0&_nc_ohc=OJUCMD0cz8sAX929JAg&_nc_ht=scontent.fcgk27-1.fna&oh=00_AfAql1vtroWjeyiDoxvjyCe07Ajttnv48E7Z1OwCJyK8wQ&oe=636F4993';
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUser();
    Provider.of<CreateRequestController>(context, listen: false)
        .getTotalCreate();
    Provider.of<ChatRoomController>(context, listen: false)
        .getTotalAcceptedAndClose();
    Provider.of<CreateRequestController>(context, listen: false)
        .getDeptartement(cUser.data.hotelid!);
    Provider.of<CreateRequestController>(context, listen: false)
        .getLocation(cUser.data.hotelid!);
  }

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
