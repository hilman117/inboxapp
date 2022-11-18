import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:post/Screens/example/general_widget.dart';
import 'package:post/Screens/homescreen/pages/lost_and_found.dart';
import 'package:post/Screens/homescreen/pages/task_page.dart';
import 'package:post/Screens/settings/setting_provider.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class HomeController with ChangeNotifier {
  //changing pages in navigation bar
  int _navIndex = 0;
  int get navIndex => _navIndex;
  final pages = [TaskPage(), LostAndFoundList()];
  changePage(int val) {
    _navIndex = val;
    notifyListeners();
  }

  // to collapsing the search button
  bool _isCollaps = false;
  bool get isCollapse => _isCollaps;
  void changeValue() async {
    _isCollaps = !_isCollaps;
    notifyListeners();
  }

  // update status duty
  bool _isOnduty = true;
  bool get isOnduty => _isOnduty;
  void changeDutyStatus(bool value) {
    _isOnduty = value;
    box!.putAll({'dutyStatus': value});
    notifyListeners();
  }

  String _getFoto = '';
  String get getFoto => _getFoto;
  getPhotoProfile(BuildContext context) async {
    var fotoUser = await FirebaseFirestore.instance
        .collection('users')
        .doc(cUser.data.email)
        .get();
    _getFoto = fotoUser['profileImage'];
    Provider.of<SettingProvider>(context, listen: false)
        .changeImageProfile(fotoUser['profileImage']);
    notifyListeners();
    print(_getFoto);
  }
}
