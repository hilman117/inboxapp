import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/lf/widget/lost_and_found_card.dart';
import 'package:post/controller/c_user.dart';

import '../../../controller/c_new.dart';

class LostAndFoundList extends StatefulWidget {
  const LostAndFoundList({super.key});

  @override
  State<LostAndFoundList> createState() => _LostAndFoundListState();
}

class _LostAndFoundListState extends State<LostAndFoundList>
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

  changed() {
    cNew.setData(true);
    Future.delayed(
      Duration(seconds: 2),
      () {
        cNew.setData(false);
      },
    );
  }

  @override
  void initState() {
    super.initState();
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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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

  String textInput = '';
  int get increment => _increment.value;
  @override
  Widget build(BuildContext context) {
    final cUser = Get.put(CUser());
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                splashRadius: 20, onPressed: () {}, icon: Icon(Icons.sort))
          ],
          title: Text(
            'Your lost and found report',
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Colors.black54),
          ),
          elevation: 0.5,
          backgroundColor: Colors.white,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Hotel List')
              .doc(cUser.data.hotelid)
              .collection('lost and found')
              .where("founder", isEqualTo: cUser.data.name)
              .snapshots(),
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
            list.sort((a, b) => b["time"].compareTo(a["time"]));
            setiniTotal(snapshot.data!.size);
            setincrement(increment + 1);
            return ListView.builder(
                padding: EdgeInsets.only(top: 5),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> data =
                      list[index].data()! as Map<String, dynamic>;

                  print(data["founder"]);
                  if (textInput.isEmpty && data['status'] == "New") {
                    return AnimatedBuilder(
                        animation: _controller,
                        builder: (BuildContext context, Widget? child) {
                          return LoasNfoundCard(
                            data: data,
                            animationColor: bgColor.evaluate(
                                AlwaysStoppedAnimation(_controller.value)),
                          );
                        });
                  }
                  if (data['location']
                      .toString()
                      .toLowerCase()
                      .contains(textInput.toLowerCase())) {
                    return LoasNfoundCard(
                      data: data,
                      animationColor: bgColor
                          .evaluate(AlwaysStoppedAnimation(_controller.value)),
                    );
                  }
                  if (data['nameItem']
                      .toString()
                      .toLowerCase()
                      .contains(textInput.toLowerCase())) {
                    return LoasNfoundCard(
                      data: data,
                      animationColor: bgColor
                          .evaluate(AlwaysStoppedAnimation(_controller.value)),
                    );
                  }
                  if (data['founder']
                      .toString()
                      .toLowerCase()
                      .contains(textInput.toLowerCase())) {
                    return LoasNfoundCard(
                      data: data,
                      animationColor: bgColor
                          .evaluate(AlwaysStoppedAnimation(_controller.value)),
                    );
                  }
                  return Center(
                    child: Text("No Data"),
                  );
                });
          },
        ));
  }
}
