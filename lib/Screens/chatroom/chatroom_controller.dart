import 'dart:io';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'package:uuid/uuid.dart';
import '../../controller/c_user.dart';
import '../../main.dart';
import '../../service/notif.dart';

class ChatRoomController with ChangeNotifier {
  final cUser = Get.put(CUser());
  FirebaseAuth auth = FirebaseAuth.instance;

  // File? _image;
  // File? get images => _image;
  // String imageUrl = "";
  TextEditingController descriptionController = TextEditingController();
  String imageName = '';
  final ImagePicker _picker = ImagePicker();
  XFile? _fromCamera;
  XFile? get fromCamera => _fromCamera;
  List<XFile?> _imageList = [];
  List<XFile?> get imagesList => _imageList;
  List<String> _imageUrl = [];
  List<String> get imageUrls => _imageUrl;
  Future<void> selectImage(ImageSource source) async {
    List<XFile?> selectedImage = await _picker.pickMultiImage(imageQuality: 30);
    if (selectedImage.isNotEmpty) {
      _imageList.addAll(selectedImage);
      notifyListeners();
      print(_imageList.length);
    }
  }

  Future<void> selectFromCamera() async {
    _fromCamera =
        await _picker.pickImage(imageQuality: 30, source: ImageSource.camera);
    if (_fromCamera != null) {
      _imageList.add(_fromCamera);
      print(_imageList.length);
    }
    notifyListeners();
  }

  void removeSingleImage(int index) {
    _imageList.removeAt(index);
    imageName = '';
    notifyListeners();
  }

  void scrollMaxExtend(ScrollController scroll) {
    if (scroll.hasClients) {
      final position = scroll.position.minScrollExtent;
      scroll.animateTo(position,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  void clearImage() {
    _imageList.clear();
    notifyListeners();
  }

  String _status = "";
  String get status => _status;
  String _receiver = "";
  String get receiver => _receiver;
  String _assignTo = "";
  String get assignTo => _assignTo;
  changeStatus(
      String newStatus, String newReceiver, String newAssignmentTarget) {
    _status = newStatus;
    _receiver = newReceiver;
    _assignTo = newAssignmentTarget;
    notifyListeners();
  }

  //function untuk mengirim kan komen.....
  bool _isTyping = false;
  bool get isTypping => _isTyping;
  String _value = '';
  String get nilai => _value;
  void typing(String value) {
    _value = value;
    if (_value.isNotEmpty) {
      _isTyping = true;
    } else {
      _isTyping = false;
    }
    notifyListeners();
  }

  bool _isImageLoad = false;
  bool get isImageLoad => _isImageLoad;
  void loadimage(bool newValue) {
    _isImageLoad = newValue;
    notifyListeners();
  }

  final TextEditingController commentBody = TextEditingController();
  void sendComment(
    String taskId,
    String location,
    String title,
    ScrollController scroll,
    String deptSender,
    String deptTujuan,
  ) async {
    _imageUrl.clear();

    notifyListeners();
    print(_isImageLoad);
    if (_imageList.isNotEmpty) {
      _imageList.forEach((element) async {
        String imageExtension = imageName.split('.').last;
        _isImageLoad = true;
        notifyListeners();
        final ref = FirebaseStorage.instance.ref(
            "${cUser.data.hotelid}/${cUser.data.uid} + ${DateTime.now().toString()}.$imageExtension");
        await ref.putFile(File(element!.path));
        await ref.getDownloadURL().then((value) async {
          _imageUrl.add(value);
          notifyListeners();
          print("ini image list sebelum di upload ${_imageList.length}");
          print(
              "ini image list stelah di upload di upload ${_imageUrl.length}");
          print("$_imageUrl");
          if (_imageUrl.length == _imageList.length) {
            _imageList.clear();
            await FirebaseFirestore.instance
                .collection('Hotel List')
                .doc(cUser.data.hotelid)
                .collection('tasks')
                .doc(taskId)
                .update({
              'comment': FieldValue.arrayUnion([
                {
                  "timeSent": DateTime.now(),
                  'accepted': "",
                  'assignTask': "",
                  'assignTo': "",
                  'commentBody': commentBody.text,
                  'commentId': Uuid().v4(),
                  'description': '',
                  'esc': '',
                  'imageComment': _imageUrl,
                  'sender': cUser.data.name,
                  'senderemail': auth.currentUser!.email,
                  'setDate': '',
                  'setTime': '',
                  'time': DateTime.now(),
                  'titleChange': "",
                  'newlocation': "",
                  'hold': "",
                  'resume': "",
                  'scheduleDelete': "",
                }
              ])
            });
            _isImageLoad = false;
            notifyListeners();
          }
        });
      });
    } else {
      await FirebaseFirestore.instance
          .collection('Hotel List')
          .doc(cUser.data.hotelid)
          .collection('tasks')
          .doc(taskId)
          .update({
        'comment': FieldValue.arrayUnion([
          {
            "timeSent": DateTime.now(),
            'accepted': "",
            'assignTask': "",
            'assignTo': "",
            'commentBody': commentBody.text,
            'commentId': Uuid().v4(),
            'description': '',
            'esc': '',
            'imageComment': [],
            'sender': cUser.data.name,
            'senderemail': auth.currentUser!.email,
            'setDate': '',
            'setTime': '',
            'time': DateTime.now(),
            'titleChange': "",
            'newlocation': "",
            'hold': "",
            'resume': "",
            'scheduleDelete': "",
          }
        ]),
      });
    }
    _isTyping = false;

    _value = '';
    if (box!.get('sendNotification') == true &&
        deptTujuan == cUser.data.department) {
      Notif().sendNotif(
        deptSender,
        '$location - "$title"',
        "${cUser.data.name} : ${commentBody.text}",
      );
      Notif().sendNotif(
        taskId,
        '$location - "$title"',
        "${cUser.data.name} : ${commentBody.text}",
      );
      commentBody.clear();

      notifyListeners();
    }
    if (box!.get('sendNotification') == true &&
        deptSender == cUser.data.department) {
      Notif().sendNotif(
        deptTujuan,
        '$location - "$title"',
        "${cUser.data.name} : ${commentBody.text}",
      );
      Notif().sendNotif(
        taskId,
        '$location - "$title"',
        "${cUser.data.name} : ${commentBody.text}",
      );
      commentBody.clear();

      notifyListeners();
    }
    if (deptTujuan != cUser.data.department ||
        deptSender != cUser.data.department) {
      Notif().saveTopic(taskId);
      notifyListeners();
    }
    scrollMaxExtend(scroll);
    Future.delayed(
      Duration(seconds: 4),
      () async {
        FirebaseFirestore.instance
            .collection('Hotel List')
            .doc(cUser.data.hotel)
            .collection('tasks')
            .doc(taskId)
            .update({'isFading': false});
        notifyListeners();
      },
    );
    // Future.delayed(
    //   Duration(milliseconds: 3000),
    //   () {
    //     _isImageLoad = false;
    //     notifyListeners();
    //   },
    // );
    // print(_isImageLoad);
    notifyListeners();
  }

//funtion untuk terima....................................................
  //to update how many requests are accepted by this user
  int _acceptedTotal = 0;
  int get acceptedTotal => _acceptedTotal;
  int _closeTotal = 0;
  int get closeTotal => _closeTotal;
  getTotalAcceptedAndClose() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser!.email)
        .get();
    _closeTotal = userDoc['closeRequest'];
    _acceptedTotal = userDoc['acceptRequest'];
    print('this is total request are accepted by this user $_acceptedTotal');
    print('this is total request are close by this user $_closeTotal');
    notifyListeners();
  }

  int? _newTotalAccepted;
  int? get newTotalAccepted => _newTotalAccepted;
  addNewAcceptedTotal(BuildContext context, int addOne) {
    if (_newTotalAccepted == null) {
      _newTotalAccepted = _acceptedTotal + addOne;
      notifyListeners();
    } else {
      _newTotalAccepted = (newTotalAccepted! + addOne);
      notifyListeners();
    }
  }

  void accept(
      BuildContext context,
      String taskId,
      String emailSender,
      String location,
      String title,
      ScrollController scroll,
      String deptTujuan) async {
    // if (imageName != '') {
    //   String imageExtension = imageName.split('.').last;
    //   final ref = FirebaseStorage.instance.ref(
    //       "${cUser.data.hotelid!}/${auth.currentUser!.uid + DateTime.now().toString()}.$imageExtension");
    //   await ref.putFile(_image!);
    //   imageUrl = await ref.getDownloadURL();
    // }
    await FirebaseFirestore.instance
        .collection('Hotel List')
        .doc(cUser.data.hotel)
        .collection('tasks')
        .doc(taskId)
        .update({
      "status": "Accepted",
      'isFading': true,
      "receiver": "${cUser.data.name}",
      "emailReceiver": cUser.data.email,
      "comment": FieldValue.arrayUnion([
        {
          "timeSent": DateTime.now(),
          'accepted': cUser.data.name,
          'assignTask': "",
          'assignTo': "",
          'commentBody': '',
          'commentId': Uuid().v4(),
          'description': "",
          'esc': '',
          'imageComment': [],
          'sender': cUser.data.name,
          'senderemail': auth.currentUser!.email,
          'setDate': '',
          'setTime': '',
          'time': DateTime.now(),
          'titleChange': "",
          'newlocation': "",
          'hold': "",
          'resume': "",
          'scheduleDelete': "",
        }
      ])
    });
    if (deptTujuan != cUser.data.department) {
      Notif().saveTopic(taskId);
    }
    addNewAcceptedTotal(context, 1);
    FirebaseFirestore.instance
        .collection('users')
        .doc(cUser.data.email)
        .update({'acceptRequest': _newTotalAccepted});
    changeStatus("Accepted", cUser.data.name!, '');
    Future.delayed(
      Duration(seconds: 4),
      () async {
        FirebaseFirestore.instance
            .collection('Hotel List')
            .doc(cUser.data.hotel)
            .collection('tasks')
            .doc(taskId)
            .update({'isFading': false});
        notifyListeners();
      },
    );
    var result = await FirebaseFirestore.instance
        .collection('users')
        .doc(emailSender)
        .get();
    print(emailSender);
    List token = result.data()!["token"];
    bool receiveNotifWhenAccepted = result.data()!['ReceiveNotifWhenAccepted'];
    print("$receiveNotifWhenAccepted ====================================");
    if (receiveNotifWhenAccepted == true && token.isNotEmpty) {
      token.forEach(
        (element) {
          Notif().sendNotifToToken(element, '$location - "$title"',
              "${cUser.data.name} accept your request", '');
        },
      );
    }
    notifyListeners();
    scrollMaxExtend(scroll);
  }

//function untuk assign....................................................
  TextEditingController searchController = TextEditingController();
  List<String> departments = [];
  String selectedDept = '';
  String selectedName = '';
  String selectedEmail = '';
  List<String> receiverAssignment = [];
  List<String> names = [];
  List<bool>? boolLlistemployee;
  List<String> emailList = [];
  bool _isGroup = true;
  bool get isGroup => _isGroup;
  int _radioValue = 0;
  int get radioValue => _radioValue;

  String _textInput = '';
  String get textInput => _textInput;

  void searchFuntion(String value) {
    _textInput = value;
    notifyListeners();
  }

  void valueRadio0() {
    _radioValue = 0;
    _isGroup = true;
    notifyListeners();
  }

  void valueRadio1() {
    _radioValue = 1;
    _isGroup = false;
    notifyListeners();
  }

  List<String> departmentsAndNamesSelected = [];
  List<String> listEmail = [];
  List<bool> statusDutyList = [];
  bool _isSwitchedGoup = false;
  bool get isSwitchedGoup => _isSwitchedGoup;
  bool _isSwitchedEmpolyee = false;
  bool get isSwitchedEmpolyee => _isSwitchedEmpolyee;

  void selectFucntionEmployee(bool value, int index) {
    boolLlistemployee![index] = value;
    if (boolLlistemployee![index]) {
      selectedName = names[index];
      selectedEmail = emailList[index];
      departmentsAndNamesSelected.addAll([names[index]]);
      listEmail.addAll([emailList[index]]);
    } else {
      departmentsAndNamesSelected.remove(names[index]);
      listEmail.remove(emailList[index]);
      selectedName = '';
      selectedEmail = '';
    }
    // _isSwitchedEmpolyee = value;
    print("$selectedName ini name yg terpilih");
    print("$listEmail ini email yg terpilih");
    print("$departmentsAndNamesSelected ini name yg masuk list");
    notifyListeners();
  }

  List<bool>? boolLlistGroup;
  getDeptartementAndNames() async {
    _isLoading = true;
    notifyListeners();
    //get the list of employees name
    var resultName = await FirebaseFirestore.instance
        .collection("users")
        .where("hotelid", isEqualTo: cUser.data.hotelid)
        .get();
    Set listName = resultName.docs.map((e) => e.data()['name']).toSet();
    Set listemail = resultName.docs.map((e) => e.data()['email']).toSet();
    List statusDuty = resultName.docs.map((e) => e.data()['isOnDuty']).toList();
    List<String> listNames = List.castFrom(listName.toList());
    List<String> listEmail = List.castFrom(listemail.toList());
    List<bool> listStatusDuty = List.castFrom(statusDuty.toList());
    names.addAll(listNames);
    emailList.addAll(listEmail);
    boolLlistemployee = List.filled(listNames.length, false);
    statusDutyList.addAll(listStatusDuty);
    //get the list of departments
    var resultDept = await FirebaseFirestore.instance
        .collection("users")
        .where("hotelid", isEqualTo: cUser.data.hotelid)
        .get();
    Set listDepartement =
        resultDept.docs.map((e) => e.data()['department']).toSet();
    List<String> listDept = List.castFrom(listDepartement.toList());
    departments.addAll(listDept);
    boolLlistGroup = List.filled(listDept.length, false);
    _isLoading = false;
    notifyListeners();
  }

  List<String> listDept = [];
  void selectFucntionGroup(bool value, int index) {
    boolLlistGroup![index] = value;
    if (boolLlistGroup![index]) {
      selectedDept = departments[index];
      departmentsAndNamesSelected.addAll([departments[index]]);
      listDept.addAll([departments[index]]);
    } else {
      departmentsAndNamesSelected.remove(departments[index]);
      listDept.remove(departments[index]);
      selectedDept = '';
    }
    print("$departmentsAndNamesSelected semua yang terpilih");

    notifyListeners();
  }

  void clearListAssign() {
    searchController.clear();
    departments.clear();
    selectedDept = '';
    selectedName = '';
    selectedEmail = '';
    departmentsAndNamesSelected.clear();
    _textInput = '';
    names.clear();
    listDept.clear();
    listEmail.clear();
    statusDutyList.clear();
    _isSwitchedEmpolyee = false;
    _isSwitchedGoup = false;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> assign(BuildContext context, String taskId, String emailSender,
      String location, String title, ScrollController scroll) async {
    await FirebaseFirestore.instance
        .collection('Hotel List')
        .doc(cUser.data.hotel)
        .collection('tasks')
        .doc(taskId)
        .update({
      "status": "Assigned",
      'isFading': true,
      "assigned": FieldValue.arrayUnion(departmentsAndNamesSelected),
      "comment": FieldValue.arrayUnion([
        {
          "timeSent": DateTime.now(),
          'accepted': "",
          'assignTask': "",
          'assignTo': departmentsAndNamesSelected.join(', '),
          'commentBody': '',
          'commentId': Uuid().v4(),
          'description': "",
          'esc': '',
          'imageComment': [],
          'sender': cUser.data.name,
          'senderemail': auth.currentUser!.email,
          'setDate': '',
          'setTime': '',
          'time': DateTime.now(),
          'titleChange': "",
          'newlocation': "",
          'hold': "",
          'resume': "",
          'scheduleDelete': "",
        }
      ])
    });
    changeStatus("Assigned", '', departmentsAndNamesSelected.last.toString());
    notifyListeners();
    Future.delayed(
      Duration(seconds: 4),
      () async {
        FirebaseFirestore.instance
            .collection('Hotel List')
            .doc(cUser.data.hotel)
            .collection('tasks')
            .doc(taskId)
            .update({'isFading': false});
        notifyListeners();
      },
    );
    if (listEmail.isNotEmpty) {
      listEmail.forEach((element) async {
        print(
            "$element------------------------------------------------------------------- yang di looping");
        var result = await FirebaseFirestore.instance
            .collection('users')
            .doc(element)
            .get();
        List token = result.data()!["token"];
        print(token);
        if (token.isNotEmpty) {
          token.forEach((element) {
            Notif().sendNotifToToken(element, '$location - "$title"',
                "${cUser.data.name} has assigned this request to you", '');
          });
        }
      });
    }
    if (listDept.isNotEmpty) {
      listDept.forEach(
        (element) {
          print(
              "$element yagng i looping------------------------------------------------------------------------");
          Notif().sendNotif(
            element.toLowerCase().removeAllWhitespace,
            '$location - "$title"',
            "${cUser.data.name} has assigned this request to $element",
          );
        },
      );
    }
    clearListAssign();
    Future.delayed(
      Duration(milliseconds: 1000),
      () {
        _isLoading = false;
      },
    );
    notifyListeners();
    Navigator.pop(context);
    scrollMaxExtend(scroll);
  }

  //function untuk close task....
  int? _newTotalClose;
  int? get newTotalClose => _newTotalClose;
  addNewCloseTotal(BuildContext context, int addOne) {
    if (_newTotalClose == null) {
      _newTotalClose = _closeTotal + addOne;
      notifyListeners();
    } else {
      _newTotalClose = (newTotalClose! + addOne);
      notifyListeners();
    }
  }

  Future<void> close(
      BuildContext context,
      String taskId,
      String location,
      String title,
      ScrollController scroll,
      String reason,
      String email,
      String deptTujuan) async {
    await FirebaseFirestore.instance
        .collection('Hotel List')
        .doc(cUser.data.hotel)
        .collection('tasks')
        .doc(taskId)
        .update({
      "status": "Close",
      'isFading': true,
      "receiver": cUser.data.name,
      "comment": FieldValue.arrayUnion([
        {
          "timeSent": DateTime.now(),
          'accepted': "",
          'assignTask': "",
          'assignTo': departmentsAndNamesSelected.join(', '),
          'commentBody': 'has close this request',
          'commentId': Uuid().v4(),
          'description': reason,
          'esc': '',
          'imageComment': [],
          'sender': cUser.data.name,
          'senderemail': auth.currentUser!.email,
          'setDate': '',
          'setTime': '',
          'time': DateTime.now(),
          'titleChange': "",
          'newlocation': "",
          'hold': "",
          'resume': "",
          'scheduleDelete': "",
        }
      ])
    });
    changeStatus("Close", cUser.data.name!, "");
    addNewCloseTotal(context, 1);
    FirebaseFirestore.instance
        .collection('users')
        .doc(cUser.data.email)
        .update({'closeRequest': newTotalClose});
    Future.delayed(
      Duration(seconds: 4),
      () async {
        FirebaseFirestore.instance
            .collection('Hotel List')
            .doc(cUser.data.hotel)
            .collection('tasks')
            .doc(taskId)
            .update({'isFading': false});
        notifyListeners();
      },
    );
    if (deptTujuan != cUser.data.department) {
      Notif().saveTopic(taskId);
    }
    Navigator.pop(context);
    Notif().sendNotif(
      taskId.toLowerCase().removeAllWhitespace,
      '$location - "$title"',
      "${cUser.data.name} has close this request \n$reason",
    );
    var result =
        await FirebaseFirestore.instance.collection('users').doc(email).get();
    List token = result.data()!["token"];
    bool receiveNotifWhenClose = result.data()!['ReceiveNotifWhenClose'];
    if (receiveNotifWhenClose == true && token.isNotEmpty) {
      token.forEach(
        (element) {
          Notif().sendNotifToToken(element, '$location - "$title"',
              "${cUser.data.name} close this request", '');
        },
      );
    }
    notifyListeners();
    scrollMaxExtend(scroll);
  }

  //reopen task.....
  Future<void> reopen(BuildContext context, String taskId, String location,
      String title, ScrollController scroll, String deptTujuan) async {
    await FirebaseFirestore.instance
        .collection('Hotel List')
        .doc(cUser.data.hotel)
        .collection('tasks')
        .doc(taskId)
        .update({
      "status": "Reopen",
      'isFading': true,
      "receiver": "${cUser.data.name}",
      "comment": FieldValue.arrayUnion([
        {
          "timeSent": DateTime.now(),
          'accepted': '',
          'assignTask': "",
          'assignTo': '',
          'commentBody': 'has reopen this request',
          'commentId': Uuid().v4(),
          'description': '',
          'esc': '',
          'imageComment': [],
          'sender': cUser.data.name,
          'senderemail': auth.currentUser!.email,
          'setDate': '',
          'setTime': '',
          'time': DateTime.now(),
          'titleChange': "",
          'newlocation': "",
          'hold': "",
          'resume': "",
          'scheduleDelete': "",
        }
      ])
    });
    changeStatus("Reopen", cUser.data.name!, "");
    Future.delayed(
      Duration(seconds: 4),
      () async {
        FirebaseFirestore.instance
            .collection('Hotel List')
            .doc(cUser.data.hotel)
            .collection('tasks')
            .doc(taskId)
            .update({'isFading': false});
        notifyListeners();
      },
    );
    if (deptTujuan != cUser.data.department) {
      Notif().saveTopic(taskId);
    }
    Notif().sendNotif(
      taskId.toLowerCase().removeAllWhitespace,
      '$location - "$title"',
      "${cUser.data.name} has reopen this request",
    );
    Notif().sendNotif(
      deptTujuan.toLowerCase().removeAllWhitespace,
      '$location - "$title"',
      "${cUser.data.name} has reopen this request",
    );
    clearListAssign();
    scrollMaxExtend(scroll);
    notifyListeners();
  }

  Future<void> changeValueOfFading(String taskId) async {
    Future.delayed(
      Duration(seconds: 4),
      () async {
        FirebaseFirestore.instance
            .collection('Hotel List')
            .doc(cUser.data.hotel)
            .collection('tasks')
            .doc(taskId)
            .update({'isFading': false});
        notifyListeners();
      },
    );
    notifyListeners();
  }

  //this is function for lf chat
  List totalEmailAdmin = [];
  getAdminData() async {
    var result = await FirebaseFirestore.instance
        .collection("Hotel List")
        .doc(cUser.data.hotelid)
        .get();
    List<dynamic> dataAdmin = result.data()!["admin"];
    dataAdmin.forEach((element) {
      List list = element['housekeeping'];
      // print(list);
      list.forEach((element) async {
        var getToken = await FirebaseFirestore.instance
            .collection("users")
            .doc(element)
            .get();
        List listToken = getToken['token'];
        listToken.forEach((element) {
          print(element);
        });
      });
    });
    notifyListeners();
  }

  void saveNetworkImage(String url) async {
    print("----------------------");
    print("save network image");
    final temDir = await getTemporaryDirectory();
    final path = '${temDir.path}/myfile.jpg';
    // await Dio().download(url, path);
    final respon = await http.get(Uri.parse(url));
    final bytes = respon.bodyBytes;
    File(path).writeAsBytesSync(bytes);
    var result = await GallerySaver.saveImage(path, albumName: "POST");
    print("Hasil: $result");
    if (result == true) {
      Fluttertoast.showToast(
          msg: "Image Saved",
          textColor: Colors.green.shade900,
          backgroundColor: Colors.white);
    } else {
      Fluttertoast.showToast(
          msg: "Failed to download",
          textColor: Colors.red.shade900,
          backgroundColor: Colors.white);
    }
  }

  int current = 0;
  final CarouselController controller = CarouselController();
  void currentIndex(int index) {
    current = index;
    notifyListeners();
  }
}
