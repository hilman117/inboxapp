import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:post/Screens/create/create_request_controller.dart';
import 'package:post/Screens/dasboard/widget/card.dart';
import 'package:post/service/notif.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../sign_up/signup.dart';

class PopUpMenuProvider with ChangeNotifier {
  //ini methode untuk mengganti title
  String _title = "";
  String get title => _title;
  void changeTitle(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }

  bool _isTitleChange = false;
  bool get isTitleChange => _isTitleChange;
  isChangeTitle(bool newValue) {
    _isTitleChange = newValue;
    notifyListeners();
  }

  void storeNewTitle(BuildContext context, String tasksId, int index,
      String emailSender) async {
    List listTitle =
        Provider.of<CreateRequestController>(context, listen: false).title;
    await FirebaseFirestore.instance
        .collection("Hotel List")
        .doc(cUser.data.hotelid)
        .collection("tasks")
        .doc(tasksId)
        .update({
      "comment": FieldValue.arrayUnion([
        {
          'commentId': Uuid().v4(),
          'commentBody': "",
          'esc': '',
          'accepted': "",
          'titleChange': "$_title to ${listTitle[index]}",
          'assignTask': "",
          'assignTo': "",
          'sender': cUser.data.name,
          'description': "",
          'senderemail': auth.currentUser!.email,
          'imageComment': "",
          'time': DateFormat('MMM d, h:mm a').format(DateTime.now()).toString(),
        }
      ]),
      "title": listTitle[index]
    });
    var result = await FirebaseFirestore.instance
        .collection('users')
        .doc(emailSender)
        .get();
    List token = result.data()!["token"];
    if (token.isNotEmpty) {
      token.forEach(
        (element) {
          Notif().sendNotifToToken(
              element,
              _title,
              "${cUser.data.name} has change the title to ${listTitle[index]}",
              '');
        },
      );
    }
    changeTitle(listTitle[index]);
    Navigator.pop(context);
    notifyListeners();
  }
}
