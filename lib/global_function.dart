import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class GlobalFunction with ChangeNotifier {
  //check internet connection
  bool _hasInternetConnection = true;
  bool get hasInternetConnection => _hasInternetConnection;
  checkInternetConnetction() {
    InternetConnectionChecker().onStatusChange.listen((statusConnection) {
      final isConnected =
          statusConnection == InternetConnectionStatus.connected;
      _hasInternetConnection = isConnected;
      print("ini status koneksi internet $_hasInternetConnection");
      notifyListeners();
      if (_hasInternetConnection == false) {
        noInternet();
      }
    });
  }

  Future<bool?> noInternet() {
    return Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg: "No internet - Please check your connection",
        backgroundColor: Colors.white,
        textColor: Colors.black,
        toastLength: Toast.LENGTH_LONG);
  }
}
