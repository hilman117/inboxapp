import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:post/Screens/dasboard/widget/card.dart';
import 'package:post/Screens/homescreen/home.dart';
import 'package:uuid/uuid.dart';

import '../../service/notif.dart';
import '../sign_up/signup.dart';

class CreateRequestController with ChangeNotifier {
  bool _isCreateRequest = true;
  bool get isCreateRequest => _isCreateRequest;
  bool _isLfReport = false;
  bool get isLfReport => _isLfReport;
  void checkBoxCreateRequest() {
    _isCreateRequest = true;
    _isLfReport = false;
    // _isLoading = false;
    notifyListeners();
  }

  void checkBoxLf() {
    _isCreateRequest = false;
    _isLfReport = true;
    // _isLoading = false;
    notifyListeners();
  }

  List<String> _departments = [];
  List<String> get departments => _departments;
  getDeptartement(String hotelid) async {
    _departments.clear();
    var result = await FirebaseFirestore.instance
        .collection("users")
        .where("hotelid", isEqualTo: hotelid)
        .get();
    Set listDepartement =
        result.docs.map((e) => e.data()['department']).toSet();
    List<String> list = List.castFrom(listDepartement.toList());
    _departments.addAll(list);
    print(_departments);
    notifyListeners();
  }

  String _selectedDept = 'Choose Department';
  String get selectedDept => _selectedDept;
  void selectDept(int index) {
    _selectedDept = _departments[index];
    _selectedTitle = 'Input Title';
    print(_selectedDept);
    notifyListeners();
  }

  void clearData() {
    _selectedDept = 'Choose Department';
    _selectedTitle = 'Input Title';
    notifyListeners();
  }

  List<String> _title = [];
  List<String> get title => _title;
  String _selectedTitle = 'Input Title';
  String get selectedtitle => _selectedTitle;
  getTitle(String hotelid, String selectedDept) async {
    _title.clear();
    var result = await FirebaseFirestore.instance
        .collection("Hotel List")
        .doc(hotelid)
        .collection("Department")
        .doc(selectedDept)
        .get();
    print(result.data()!['title'].runtimeType);
    List<String> list = List.castFrom(result.data()!['title']);
    _title.addAll(list);
    notifyListeners();
  }

  void selectTitle(BuildContext context, int index) {
    _selectedTitle = _title[index];
    Navigator.pop(context);
    _searchtitle.clear();
    print(_selectedTitle);
    notifyListeners();
  }

  TextEditingController _searchtitle = TextEditingController();
  TextEditingController get searchtitle => _searchtitle;
  String _searchTitle = '';
  String get searchTitle => _searchTitle;
  void setstate(String value) {
    _searchTitle = value;
    notifyListeners();
  }

  void clearSearchTitle() {
    _searchtitle.clear();
    _searchTitle = '';
    notifyListeners();
  }

  List<String> _data = [];
  List<String> get data => _data;
  getLocation(String hotelId) async {
    _selectedLocation.clear();
    _data.clear();
    var result = await FirebaseFirestore.instance
        .collection("Hotel List")
        .doc(hotelId)
        .get();
    print(result.data()!['location']);
    print(result.data()!['location'].runtimeType);
    List<String> list = List.castFrom(result.data()!['location']);
    _data.addAll(list);
    print("$list ----------------------------------------------------");
    notifyListeners();
  }

  Future searchLocation(String param) async {
    List<String> result = data
        .where((element) => element.toLowerCase().contains(param.toLowerCase()))
        .toList();
    return result;
  }

  TextEditingController _selectedLocation = TextEditingController();
  TextEditingController get selectedLocation => _selectedLocation;
  void selectLocation(String suggestion) {
    _selectedLocation.text = suggestion;
    notifyListeners();
  }

  String _datePicked = '';
  String get datePicked => _datePicked;
  String _timePicked = '';
  String get timePicked => _timePicked;
  dateTimePicker(BuildContext context) async {
    var resultDate = await showDatePicker(
        confirmText: "Set",
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(
            DateTime.now().month == 12
                ? DateTime.now().year + 1
                : DateTime.now().year,
            DateTime.now().month == 12 ? 1 : DateTime.now().month + 1,
            DateTime.now().day));
    if (resultDate != null) {
      var resultTime =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (resultTime != null) {
        var setDate =
            DateTime(resultDate.year, resultDate.month, resultDate.day);
        var setTime = DateTime(resultDate.hour);
        _datePicked = DateFormat('MMM d, h:mm a').format(setDate);
        _timePicked = DateFormat('h:mm a').format(setTime);
        notifyListeners();
      }
    }
  }

  void clearSchedule() {
    _datePicked = '';
    _timePicked = '';
    notifyListeners();
  }

  File? _image;
  File? get images => _image;
  String imageUrl = "";
  String imageName = '';
  TextEditingController descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Future<void> selectImage(ImageSource source) async {
    XFile? image = await _picker.pickImage(source: source, imageQuality: 30);
    _image = File(image!.path);
    imageName = image.name;
    notifyListeners();
  }

  void clearImage() {
    _image = null;
    notifyListeners();
  }

  //to update how many requests are made by this user
  int _createTotal = 0;
  int get createTotal => _createTotal;
  getTotalCreate() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser!.email)
        .get();
    _createTotal = userDoc['createRequest'];
    print('this is total request are accepted by this user $_createTotal');
    notifyListeners();
  }

  int? _newTotal;
  int? get newTotal => _newTotal;
  addNewRequestTotal(BuildContext context, int addOne) {
    if (_newTotal == null) {
      _newTotal = _createTotal + addOne;
      notifyListeners();
    } else {
      _newTotal = (newTotal! + addOne);
      notifyListeners();
    }
  }

  bool _isLoading = false;
  bool get isLodaing => _isLoading;
  String _idTask = '';
  String get idTask => _idTask;
  TextEditingController descriptionTask = TextEditingController();
  Future<void> tasks(
      BuildContext context,
      String hotelId,
      String userId,
      TextEditingController controller,
      String senderName,
      String senderDept,
      String senderEmail,
      String location) async {
    // try {
    if (_selectedDept == 'Choose Department') {
      Fluttertoast.showToast(
          msg: "No departement selected",
          backgroundColor: Colors.white,
          textColor: Colors.red);
    } else if (location.isEmpty) {
      Fluttertoast.showToast(
          msg: "Choose specific location",
          backgroundColor: Colors.white,
          textColor: Colors.red);
    } else if (_selectedTitle == 'Input Title') {
      Fluttertoast.showToast(
          msg: "Title is empty",
          backgroundColor: Colors.white,
          textColor: Colors.red);
    } else {
      _isLoading = true;
      _idTask = Uuid().v4();
      notifyListeners();
      if (imageName != '') {
        String imageExtension = imageName.split('.').last;
        final ref = FirebaseStorage.instance.ref(
            "$hotelId/${userId + DateTime.now().toString()}.$imageExtension");
        await ref.putFile(_image!);
        imageUrl = await ref.getDownloadURL();
      }
      await FirebaseFirestore.instance
          .collection('Hotel List')
          .doc(hotelId)
          .collection('tasks')
          .doc(_idTask)
          .set({
        "positionSender": cUser.data.position,
        "profileImageSender": Home.imageProfile,
        "location": location,
        "title": _selectedTitle,
        "sendTo": _selectedDept,
        "assigned": [_selectedDept],
        'setDate': _datePicked,
        'setTime': _timePicked,
        "description": controller.text,
        "time": DateTime.now().toString(),
        "sender": senderName,
        "comment": [],
        "image": imageUrl,
        "status": "New",
        "isFading": false,
        "from": senderDept,
        "receiver": "",
        "id": _idTask,
        "emailSender": senderEmail,
      });
      await FirebaseFirestore.instance
          .collection('Hotel List')
          .doc(hotelId)
          .collection('tasks')
          .doc(_idTask)
          .update({
        'comment': FieldValue.arrayUnion([
          {
            'commentId': Uuid().v4(),
            'commentBody': controller.text,
            'accepted': "",
            'esc': "",
            'assignTask': "",
            'sender': senderName,
            'description': controller.text,
            'senderemail': senderEmail,
            'imageComment': imageUrl,
            'time':
                DateFormat('MMM d, h:mm a').format(DateTime.now()).toString(),
          }
        ])
      });
      addNewRequestTotal(context, 1);
      FirebaseFirestore.instance
          .collection('users')
          .doc(cUser.data.email)
          .update({'createRequest': newTotal});
      Notif().sendNotif(
          _selectedDept.removeAllWhitespace,
          "$_selectedDept New Request",
          '$senderName send a request: ${_selectedLocation.text} - "$_selectedTitle" ${controller.text}');
      _isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.black,
          msg: "Request sent");
      await Future.delayed(Duration(milliseconds: 600));
      Get.back();
      controller.clear();
      _searchtitle.clear();
      _idTask = '';
      _image = null;

      notifyListeners();
    }
    // } catch (e) {
    //   Fluttertoast.showToast(
    //       backgroundColor: Colors.white,
    //       toastLength: Toast.LENGTH_SHORT,
    //       textColor: Colors.black,
    //       msg: "Ups! Something Wrong");
    //   print(e);
    // }
  }

  TextEditingController nameItem = TextEditingController();
  void lfReport(
      BuildContext context,
      String hotelId,
      String userId,
      TextEditingController controller,
      String senderName,
      String senderEmail,
      String location) async {
    if (location.isEmpty) {
      Fluttertoast.showToast(
          msg: "Choose specific location",
          backgroundColor: Colors.white,
          textColor: Colors.red);
    } else if (nameItem.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Name of item should be filled",
          backgroundColor: Colors.white,
          textColor: Colors.red);
    } else if (imageName.isEmpty) {
      Fluttertoast.showToast(
          msg: "Should attach an image",
          backgroundColor: Colors.white,
          textColor: Colors.red);
    } else {
      try {
        _isLoading = true;
        _idTask = Uuid().v4();
        notifyListeners();
        if (imageName != '') {
          String imageExtension = imageName.split('.').last;
          final ref = FirebaseStorage.instance.ref(
              "$hotelId/${userId + DateTime.now().toString()}.$imageExtension");
          await ref.putFile(_image!);
          imageUrl = await ref.getDownloadURL();
        }
        await FirebaseFirestore.instance
            .collection('Hotel List')
            .doc(hotelId)
            .collection('lost and found')
            .doc(_idTask)
            .set({
          "location": location,
          "nameItem": nameItem.text,
          "sendTo": "Housekeeping",
          "description": controller.text,
          "time": DateFormat('MMM d, h:mm a').format(DateTime.now()).toString(),
          "reportreceiveDate": "",
          "reportClaimedDate": "",
          "reportReleasedDate": "",
          "founder": senderName,
          "image": imageUrl,
          "imageProof": "",
          "status": "New",
          "statusReleased": "Keep",
          "receiveBy": "",
          "receiver": "",
          "positionSender": cUser.data.position,
          "profileImageSender": cUser.data.profileImage,
          "id": _idTask,
          "emailSender": senderEmail,
        });
        Notif().saveTopic(_idTask);
        Notif().sendNotif("Housekeeping".removeAllWhitespace, "New Report",
            '$senderName found: ${nameItem.text} - "${_selectedLocation.text}" ${controller.text}');
        _isLoading = false;
        Fluttertoast.showToast(
            backgroundColor: Colors.white,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.black,
            msg: "Request sent");
        await Future.delayed(Duration(milliseconds: 600));
        Get.back();
        controller.clear();
        _idTask = '';
        _image = null;
        notifyListeners();
      } catch (e) {
        Fluttertoast.showToast(
            backgroundColor: Colors.white,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.black,
            msg: "Ups! Something Wrong");
        print(e);
      }
    }
  }
}
