import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../main.dart';
import '../../models/user.dart';
import '../../service/notif.dart';
import '../../service/session_user.dart';
import '../homescreen/home.dart';

class SignInController with ChangeNotifier {
  Color themeColor = Colors.orange;
  Color cardColor = const Color(0xff475D5B);
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  UserDetails? userDetails;
  bool _isSave = box!.get('isSave') != null ? box!.get('isSave') : false;
  bool get isSave => _isSave;
  String _getEmail = box!.get('email') != null ? box!.get('email') : '';
  String get getEmail => _getEmail;
  String _getPassword =
      box!.get('password') != null ? box!.get('password') : '';
  String get getPassword => _getPassword;

  isSaveValue(bool value) {
    _isSave = !_isSave;
    box!.putAll({'isSave': _isSave});
    notifyListeners();
  }

  bool _isObsecure = true;
  bool get isObsecure => _isObsecure;
  void obsecure() {
    _isObsecure = !_isObsecure;
    notifyListeners();
  }

  List<String> listToken = [];

  Future signIn(String email, String password) async {
    if (email.isEmpty || !email.contains("@")) {
      return Fluttertoast.showToast(
          toastLength: Toast.LENGTH_LONG,
          msg: "Email Format Not Valid",
          textColor: Colors.red,
          backgroundColor: Colors.grey.shade200);
    }
    if (password.isEmpty) {
      return Fluttertoast.showToast(
          toastLength: Toast.LENGTH_LONG,
          msg: "Password Must Be Filled",
          textColor: Colors.red,
          backgroundColor: Colors.grey.shade200);
    } else {
      try {
        _isLoading = true;
        notifyListeners();
        if (_isSave) {
          await box!.putAll({'email': email});
          await box!.putAll({'password': password});
        } else {
          box!.delete('email');
          box!.delete('password');
          notifyListeners();
        }
        print("$_getEmail tersimpan dilocal storage");
        print("$_getPassword tersimpan dilocal storage");
        await auth.signInWithEmailAndPassword(
            email: email.removeAllWhitespace,
            password: password.removeAllWhitespace);
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("users")
            .doc(auth.currentUser!.email)
            .get();
        if (userDoc.data() != null) {
          userDetails =
              UserDetails.fromJson(userDoc.data() as Map<String, dynamic>);
          SessionsUser.saveUser(userDetails!);
          String token = await Notif().getToken();
          box!.put('token', token);
          listToken.clear();
          listToken.add(token);
          print("---------------------");
          print(userDetails!.department);
          Notif().saveTopic(userDetails!.department!.removeAllWhitespace);
          await FirebaseFirestore.instance
              .collection("users")
              .doc(auth.currentUser!.email)
              .update({"token": listToken});
          Fluttertoast.showToast(
              toastLength: Toast.LENGTH_LONG,
              msg: "You are sign in as ${userDetails!.name}",
              textColor: Colors.black,
              backgroundColor: Colors.grey.shade50);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          _isLoading = false;
          notifyListeners();
          Fluttertoast.showToast(
              toastLength: Toast.LENGTH_LONG,
              msg: "No user found for that email",
              textColor: Colors.red,
              backgroundColor: Colors.grey.shade200);
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          _isLoading = false;
          notifyListeners();
          Fluttertoast.showToast(
              toastLength: Toast.LENGTH_LONG,
              msg: "Wrong password provided for that user",
              textColor: Colors.red,
              backgroundColor: Colors.grey.shade200);
          _isLoading = false;
          notifyListeners();
        }
      }
      _isLoading = false;
      await Future.delayed(Duration(milliseconds: 2000), () {
        Get.off(() => Home(),
            transition: Transition.rightToLeft,
            duration: Duration(milliseconds: 700));
      });
    }
  }
}
