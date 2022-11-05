import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:post/Screens/sign_in/signin.dart';
import 'package:post/Screens/sign_up/signup.dart';
import 'package:post/controller/c_user.dart';

import '../../main.dart';

class SettingProvider with ChangeNotifier {
  final cUser = Get.put(CUser());
  Future<void> accepted(bool value) async {
    box!.putAll({'ReceiveNotifWhenAccepted': value});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.email)
        .update({'ReceiveNotifWhenAccepted': value});
    notifyListeners();
  }

  void close(bool value) async {
    box!.putAll({'ReceiveNotifWhenClose': value});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.email)
        .update({'ReceiveNotifWhenClose': value});
    notifyListeners();
  }

  void sendNotif(bool value) {
    box!.putAll({'sendNotification': value});
    print("${box!.get('sendNotification')} status send a chat");
    notifyListeners();
  }

  Future<void> onDuty(bool value) async {
    box!.putAll({'isOnDuty': value});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.email)
        .update({'isOnDuty': value});
    print("${box!.get('isOnDuty')} status send a duty");
    notifyListeners();
  }

  bool _isLoad = false;
  bool get isLoad => _isLoad;
  void signOut(BuildContext context) async {
    // Navigator.pop(context);
    // _isLoad = false;
    // notifyListeners();
    // Get.offAll(() => SignIn(), transition: Transition.leftToRight);
    String token = box!.get('token');
    if (token.isNotEmpty) {
      _isLoad = true;
      notifyListeners();
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(auth.currentUser!.email)
            .update({'token': [].remove(token)});
        FirebaseMessaging.instance
            .unsubscribeFromTopic(cUser.data.department!.removeAllWhitespace);
        cUser.data.name = '';
        cUser.data.department = '';
        cUser.data.email = '';
        cUser.data.hotel = '';
        cUser.data.hotelid = '';
        await auth.signOut();
        Navigator.pop(context);
        _isLoad = false;
        notifyListeners();
        Get.offAll(() => SignIn(), transition: Transition.leftToRight);
      } catch (e) {
        _isLoad = false;
        notifyListeners();
        Fluttertoast.showToast(
            toastLength: Toast.LENGTH_LONG,
            msg: "Something Wrong!",
            textColor: Colors.red,
            backgroundColor: Colors.grey.shade200);
      }
    }
  }
}
