import 'package:flutter/material.dart';

class ProfileController with ChangeNotifier {
  String _isTyping = "";
  String get istyping => _isTyping;
  TextEditingController typing = TextEditingController();
  isUsertyping(String value) {
    _isTyping = value;
    notifyListeners();
  }
}
