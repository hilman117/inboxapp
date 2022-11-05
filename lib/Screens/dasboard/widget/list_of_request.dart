import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:post/Screens/dasboard/dashboard_provider.dart';
import 'package:post/service/notif.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../../controller/c_new.dart';
import '../../../controller/c_user.dart';
import '../../../models/tasks.dart';
import 'card.dart';

class ListOfRequest extends StatefulWidget {
  const ListOfRequest({
    Key? key,
    required this.streamMine,
  }) : super(key: key);
  final Stream<QuerySnapshot<Map<String, dynamic>>> streamMine;

  @override
  State<ListOfRequest> createState() => _ListOfRequestState();
}

class _ListOfRequestState extends State<ListOfRequest>
    with SingleTickerProviderStateMixin {
  FirebaseAuth auth = FirebaseAuth.instance;
  Animatable<Color?> bgColor = TweenSequence<Color?>([
    TweenSequenceItem(
        tween: ColorTween(begin: Colors.white, end: Colors.blue.shade100),
        weight: 1.0),
    TweenSequenceItem(
        tween: ColorTween(begin: Colors.blue.shade100, end: Colors.white),
        weight: 1.0),
    TweenSequenceItem(
        tween: ColorTween(begin: Colors.white, end: Colors.blue.shade100),
        weight: 1.0),
    TweenSequenceItem(
        tween: ColorTween(begin: Colors.blue.shade100, end: Colors.white),
        weight: 1.0),
  ]);

  late AnimationController _controller;
  TextEditingController searchController = TextEditingController();
  // final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  bool isSearch = true;

  Timer? everyMinutes;

  changed() {
    cNew.setData(true);
    Future.delayed(
      Duration(seconds: 2),
      () {
        cNew.setData(false);
      },
    );
  }

  late File _image;
  String imageName = '';
  String imageUrl = "";

  void esc(String bodyMessage, String topic, String idTask, String location,
      String title) async {
    if (imageName != '') {
      String imageExtension = imageName.split('.').last;
      final ref = FirebaseStorage.instance.ref(
          "${cUser.data.hotelid!}/${auth.currentUser!.uid + DateTime.now().toString()}.$imageExtension");
      await ref.putFile(_image);
      imageUrl = await ref.getDownloadURL();
    }
    await FirebaseFirestore.instance
        .collection('Hotel List')
        .doc(cUser.data.hotelid)
        .collection('Others')
        .doc(idTask)
        .update({
      "status": "ESC",
      "receiver": "",
      "comment": FieldValue.arrayUnion([
        {
          'commentId': Uuid().v4(),
          'commentBody': "",
          "assignTask": "",
          'accepted': "",
          'esc': "Escalation after 5 minutes",
          'sender': "POST",
          'description': "",
          'senderemail': auth.currentUser!.email,
          'imageComment': imageUrl,
          'time': DateFormat('MMM d, h:mm a').format(DateTime.now()).toString(),
        }
      ])
    });
    Notif().sendNotif(topic, '$location - "$title"', bodyMessage);
    // cAccepted.setData("ESC");
    // cAccepted.setSender(cUser.data.name!);
  }

  String taskId = '';
  String topicEsc = '';
  String location1 = '';
  String titel1 = '';
  String status1 = '';
  DateTime? waktu;
  int jarakWaktu2 = 0;
  Rx<ConnectivityResult> statusConnection = ConnectivityResult.none.obs;

  late StreamSubscription<ConnectivityResult> subscription;
  @override
  void initState() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        print("I am connected to a mobile network.");
        // I am connected to a mobile network.
        statusConnection.value = ConnectivityResult.mobile;
      }
      if (result == ConnectivityResult.wifi) {
        statusConnection.value = ConnectivityResult.wifi;
        // I am connected to a wifi network.
      } else {
        statusConnection.value = ConnectivityResult.none;
      }
      // Got a new connectivity status!
    });
    _controller = AnimationController(
        duration: const Duration(seconds: 2),
        vsync: this,
        reverseDuration: Duration(seconds: 2))
      ..repeat(reverse: true);
    Timer.periodic(Duration(minutes: 1), (Timer timer) {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    subscription.cancel();
    super.dispose();
  }

  // ignore: non_constant_identifier_names
  final cUser = Get.put(CUser());
  final cNew = Get.put(Cnew());
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxInt _iniTotal = 0.obs;
  setiniTotal(n) => _iniTotal.value = n;
  int get initotal => _iniTotal.value;
  int data1 = 0;
  int data2 = 0;

  RxInt _increment = 0.obs;
  setincrement(n) {
    _controller
        .animateTo(1.0)
        .then<TickerFuture>((value) => _controller.animateBack(0.0));

    _increment.value = n;
    if (n == 1) {
      data1 = initotal;
    } else if (n == 2) {
      data2 = initotal;
    }
    if (data1 != data2) {
      cNew.setData(true);
      Future.delayed(
        Duration(seconds: 2),
        () {
          print("--------------------------");
          print(cNew.data);
          cNew.setData(false);
          print(cNew.data);
        },
      );
    }
  }

  int get increment => _increment.value;

  String? acceptedby;
  String time = '';
  String textInput = '';
  String? idpenerima;
  String sender = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: StreamBuilder(
          stream: widget.streamMine,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return SizedBox();
            }
            List<QueryDocumentSnapshot<Object?>> list = snapshot.data!.docs;
            Provider.of<DashboardProvider>(context)
                .totalLenght(snapshot.data!.docs);
            list.sort((a, b) => b["time"].compareTo(a["time"]));
            setiniTotal(snapshot.data!.size);
            setincrement(increment + 1);
            return ListView.builder(
                padding: EdgeInsets.only(top: 5),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> data =
                      list[index].data()! as Map<String, dynamic>;
                  TaskModel taskModel = TaskModel.fromJson(data);
                  // print(data);
                  if (textInput.isEmpty && data['status'] == "New") {
                    return AnimatedBuilder(
                        animation: _controller,
                        builder: (BuildContext context, Widget? child) {
                          return listdata(
                              data,
                              taskModel,
                              bgColor.evaluate(
                                  AlwaysStoppedAnimation(_controller.value)));
                        });
                  }
                  if (data['location']
                      .toString()
                      .toLowerCase()
                      .contains(textInput.toLowerCase())) {
                    return listdata(
                        data,
                        taskModel,
                        bgColor.evaluate(
                            AlwaysStoppedAnimation(_controller.value)));
                  }
                  if (data['title']
                      .toString()
                      .toLowerCase()
                      .contains(textInput.toLowerCase())) {
                    return listdata(
                        data,
                        taskModel,
                        bgColor.evaluate(
                            AlwaysStoppedAnimation(_controller.value)));
                  }
                  if (data['sender']
                      .toString()
                      .toLowerCase()
                      .contains(textInput.toLowerCase())) {
                    return listdata(
                        data,
                        taskModel,
                        bgColor.evaluate(
                            AlwaysStoppedAnimation(_controller.value)));
                  }
                  return Container();
                });
          },
        )
        // }),
        );
  }
}
