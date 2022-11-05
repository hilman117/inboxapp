import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../dasboard/widget/card.dart';

class ReportLFController with ChangeNotifier {
  String _receiveByFounder = '';
  String get receiveByFounder => _receiveByFounder;

  String _statusItem = '';
  String get statusItem => _statusItem;

  void receive(String id, String name) async {
    await FirebaseFirestore.instance
        .collection('Hotel List')
        .doc(cUser.data.hotel)
        .collection('lost and found')
        .doc(id)
        .update({
      // "imageProof":
      'receiveBy': name,
      'reportreceiveDate':
          DateFormat('MMM d, h:mm a').format(DateTime.now()).toString(),
      'statusReleased': 'Accepted'
    });
    _receiveByFounder = name;
    _statusItem = 'Accepted';
    notifyListeners();
  }
}
