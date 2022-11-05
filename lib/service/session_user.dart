import 'dart:convert';
import 'package:get/get.dart';
import 'package:post/controller/c_user.dart';
import 'package:post/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionsUser {
  static Future<void> saveUser(UserDetails user) async {
    final cUser = Get.put(CUser());
    cUser.setData(user);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = user.toJson();
    prefs.setString('user', jsonEncode(userMap));
  }

  static Future<UserDetails?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserDetails? user;
    String? userString = prefs.getString('user');
    if (userString != null) {
      Map<String, dynamic> userMap = jsonDecode(userString);
      user = UserDetails.fromJson(userMap);
      final cUser = Get.put(CUser());
      cUser.setData(user);
    }
    return user;
  }

  static Future<void> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }
}
