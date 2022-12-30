import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import 'common_widget/card.dart';
import 'Screens/settings/setting_provider.dart';

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

  String _getFoto = '';
  String get getFoto => _getFoto;
  Future getPhotoProfile(BuildContext context) async {
    var fotoUser = await FirebaseFirestore.instance
        .collection('users')
        .doc(cUser.data.email)
        .get();
    var data = fotoUser.data();
    String foto = data!['profileImage'];
    print(foto);
    // _getFoto = fotoUser.data()!['profileImage'];
    Provider.of<SettingProvider>(context, listen: false)
        .changeImageProfile(foto);
    notifyListeners();
    print("ini foto pofile nya $_getFoto");
  }
}
