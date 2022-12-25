import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:post/Screens/example/general_widget.dart';
import 'package:post/Screens/homescreen/pages/lost_and_found.dart';
import 'package:post/Screens/homescreen/pages/task_page.dart';
import 'package:post/Screens/settings/setting_provider.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../service/notif.dart';
import '../feeds/list_feeds.dart';

class HomeController with ChangeNotifier {
  //changing pages in navigation bar

  int _navIndex = 0;
  int get navIndex => _navIndex;
  List<Widget> pages = [
    TaskPage(controller: ScrollController()),
    Feeds(),
    LostAndFoundList()
  ];

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

  String _textInput = '';
  String get textInput => _textInput;
  final TextEditingController text = TextEditingController();
  getInputTextSearch(String value) {
    _textInput = value;
    notifyListeners();
  }

  // update status duty
  bool? _isOnduty;
  bool? get isOnduty => _isOnduty;
  void changeDutyStatus(bool value) {
    _isOnduty = value;
    box!.putAll({'dutyStatus': value});
    notifyListeners();
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

  String _taskId = '';
  String get taskId => _taskId;
  List<dynamic> _assign = [];
  List<dynamic> get assign => _assign;
  String _sendTo = "";
  String get sendTo => _sendTo;
  String _imageProfileSender = "";
  String get imageProfileSender => _imageProfileSender;
  String _positionSender = "";
  String get positionSender => _positionSender;
  String _emailSender = "";
  String get emailSender => _emailSender;
  String _location = "";
  String get location => _location;
  String _nameSender = "";
  String get nameSender => _nameSender;
  String _titleTask = '';
  String get tilteTask => _titleTask;
  String _descriptionTask = "";
  String get descriptionTask => _descriptionTask;
  String _statusTask = '';
  String get statusTask => _statusTask;
  String _penerimaTask = "";
  String get penerimaTask => _penerimaTask;
  String _hotelId = "";
  String get hotelid => _hotelId;
  DateTime _time = DateTime.now();
  DateTime get time => _time;
  String _fromWhere = "";
  String get fromWhere => _fromWhere;
  String _schedule = "";
  String get schedule => _schedule;
  bool _isFading = false;
  bool get isFading => _isFading;
  int? jarakWaktu;
  Map<String, dynamic> _data = {};
  Map<String, dynamic> get data => _data;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _newData = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get newData => _newData;
  // int index = 0;
  dataForNotiifcationAction() async {
    var data = FirebaseFirestore.instance
        .collection("Hotel List")
        .doc(cUser.data.hotelid)
        .collection("tasks")
        .where("assigned", arrayContains: cUser.data.department)
        .where("status", isNotEqualTo: "Close")
        .snapshots(includeMetadataChanges: true);
    data.map((data) {
      _newData = data.docs;
      List.generate(_newData.length, (index) {
        _taskId = _newData[index]["id"];
        _assign = _newData[index]["assigned"];
        _sendTo = _newData[index]["sendTo"];
        _imageProfileSender = _newData[index]["profileImageSender"];
        _positionSender = _newData[index]["positionSender"];
        _emailSender = _newData[index]["emailSender"];
        _location = _newData[index]["location"];
        _nameSender = _newData[index]["sender"];
        _titleTask = _newData[index]["title"];
        _descriptionTask = _newData[index]["description"];
        _statusTask = _newData[index]["status"];
        _penerimaTask = _newData[index]["receiver"];
        _time = DateTime.parse(_newData[index]["time"]);
        _fromWhere = _newData[index]["from"];
        _schedule = _newData[index]["setDate"];
        _isFading = _newData[index]["isFading"];
        notifyListeners();
      });
    }).toList();
  }

  // actionStreamNotif() {
  //   AwesomeNotifications().actionStream.listen((notif) {
  //     if (notif.channelKey == 'basic_channel' && Platform.isIOS) {
  //       AwesomeNotifications().getGlobalBadgeCounter().then(
  //           (value) => AwesomeNotifications().setGlobalBadgeCounter(value - 1));
  //     }
  //     Get.to(
  //         () => ChatRoomTask(
  //               descriptionTask: _descriptionTask,
  //               hotelid: _hotelId,
  //               location: location,
  //               nameSender: _nameSender,
  //               penerimaTask: _penerimaTask,
  //               setDate: _schedule,
  //               sendTo: _sendTo,
  //               statusTask: _statusTask,
  //               taskId: _taskId,
  //               tilteTask: _titleTask,
  //               time: _time,
  //               fromWhere: _fromWhere,
  //               emailSender: _emailSender,
  //               jarakWaktu: 0,
  //               assign: _assign,
  //               imageProfileSender: _imageProfileSender,
  //               positionSender: _positionSender,
  //               setTime: '',
  //             ),
  //         transition: Transition.rightToLeft);
  //     notifyListeners();
  //   });
  // }

  scheduleNotification(List<QueryDocumentSnapshot<Object?>> data) {
    List.generate(data.length, (index) {
      List myDept = data[index]["assigned"];
      int idSchedule = int.parse(data[index]["id"]);
      Future<List<NotificationModel>> list =
          AwesomeNotifications().listScheduledNotifications();
      list.then((value) {
        // print(value[index].content!.id);
        print("task yg diberi schedule ${value.length}");
        // print(idSchedule);
        if (value.contains(idSchedule)) {
        } else {
          if (data[index]["setDate"] != '' ||
              data[index]["setTime"] != '' &&
                  myDept.last == cUser.data.department) {
            var checkDate = data[index]["setDate"];
            var checkTime = data[index]["setTime"];
            var day = DateFormat("d").format(DateTime.parse(checkDate));
            var month = DateFormat("M").format(DateTime.parse(checkDate));
            final format = DateFormat.jm();
            TimeOfDay t = TimeOfDay.fromDateTime(format.parse(checkTime));
            // print(
            //     "ini jadwal untuk setiap tanggal $day, bulan $month, jam ${t.hour}, menit ${t.minute}");
            Notif().scheduleNotification(
                title: data[index]["title"],
                body: "Due to $day ${t.hour} ${t.minute}",
                location: data[index]["location"],
                scheduleId: idSchedule,
                month: int.parse(month),
                day: int.parse(day),
                hour: t.hour,
                minute: t.minute);
          }
        }
      });
    });
  }

  cancelScheduleNotification(int idSchedule) async {
    await AwesomeNotifications().cancelSchedule(idSchedule);
  }
}
