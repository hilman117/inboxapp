import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post/common_widget/card.dart';
import 'package:uuid/uuid.dart';

class FeedsController with ChangeNotifier {
  bool _isPostInProgress = false;
  bool get isPostInProgress => _isPostInProgress;
  String postId = Uuid().v4();

  List<XFile?> _imageList = [];
  List<XFile?> get imagesList => _imageList;
  XFile? _fromCamera;
  XFile? get fromCamera => _fromCamera;
  List<String> _imageUrl = [];
  List<String> get imageUrl => _imageUrl;
  String imageName = '';
  final ImagePicker _picker = ImagePicker();

  Future<void> selectImage(ImageSource source) async {
    List<XFile?> selectedImage = await _picker.pickMultiImage(imageQuality: 30);
    if (selectedImage.isNotEmpty) {
      _imageList.addAll(selectedImage);
      notifyListeners();
      print(_imageList.length);
    }
    notifyListeners();
  }

  Future<void> selectFromCamera() async {
    _fromCamera =
        await _picker.pickImage(imageQuality: 30, source: ImageSource.camera);
    if (_fromCamera != null) {
      _imageList.add(_fromCamera);
      notifyListeners();
      print(_imageList.length);
    }
    notifyListeners();
  }

  void removeSingleImage(int index) {
    _imageList.removeAt(index);
    imageName = '';
    notifyListeners();
  }

  bool _isTyping = false;
  bool get istyping => _isTyping;
  TextEditingController typing = TextEditingController();
  isUsertyping(bool value) {
    _isTyping = value;
    notifyListeners();
  }

  void postSomething(
      BuildContext context, String postStuff, String postId) async {
    _isPostInProgress = true;
    _imageUrl.clear();
    notifyListeners();
    if (_imageList.isNotEmpty) {
      _imageList.forEach((element) async {
        String imageExtension = imageName.split('.').last;
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
                .collection("Hotel List")
                .doc(cUser.data.hotelid)
                .collection('feeds')
                .doc(postId)
                .set({
              "name": cUser.data.name,
              "position": cUser.data.position,
              "postStuff": postStuff,
              "emailPostSender": cUser.data.email,
              "imagePostSender": cUser.data.profileImage,
              "thisPostCeatedAt": DateTime.now().toString(),
              "comment": [],
              "images": _imageUrl,
              "like": [],
            });
          }
        });
      });
    } else {
      await FirebaseFirestore.instance
          .collection("Hotel List")
          .doc(cUser.data.hotelid)
          .collection('feeds')
          .doc(postId)
          .set({
        "name": cUser.data.name,
        "position": cUser.data.position,
        "postStuff": postStuff,
        "emailPostSender": cUser.data.email,
        "imagePostSender": cUser.data.profileImage,
        "thisPostCeatedAt": DateTime.now().toString(),
        "comment": [],
        "images": [],
        "like": [],
      });
    }
    typing.clear();
    isUsertyping(false);
    Future.delayed(
      Duration(milliseconds: 3000),
      () {
        _isPostInProgress = false;
        notifyListeners();
      },
    );

    notifyListeners();
  }
}
