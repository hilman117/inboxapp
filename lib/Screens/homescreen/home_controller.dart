import 'package:flutter/material.dart';
import 'package:post/Screens/homescreen/pages/lost_and_found.dart';
import 'package:post/Screens/homescreen/pages/task_page.dart';

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

  
}
