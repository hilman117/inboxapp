import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:post/Screens/chatroom/chatroom_controller.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'group_list.dart';
import 'list_employee.dart';

Future assign(BuildContext context, String taskId, String emailSender,
    String location, String title, ScrollController scroll) {
  final provider = Provider.of<ChatRoomController>(context, listen: false);
  // ignore: unused_local_variable
  bool choose = false;
  return showAnimatedDialog(
      animationType: DialogTransitionType.slideFromRight,
      context: context,
      builder: (context) {
        return Consumer<ChatRoomController>(
            builder: (context, value, child) => ModalProgressHUD(
                  inAsyncCall: value.isLoading,
                  progressIndicator:
                      CircularProgressIndicator(color: mainColor),
                  child: StatefulBuilder(
                      builder: (context, setState) => Center(
                            child: SingleChildScrollView(
                              child: Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 2000),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 25),
                                          Text(
                                              "${AppLocalizations.of(context)!.assign} ${AppLocalizations.of(context)!.to}:",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: mainColor)),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Container(
                                              width: double.infinity,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: mainColor,
                                              ),
                                              child: Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Consumer<
                                                              ChatRoomController>(
                                                          builder: (context,
                                                                  value,
                                                                  child) =>
                                                              Radio<int>(
                                                                  activeColor:
                                                                      Colors
                                                                          .grey,
                                                                  value: 0,
                                                                  groupValue: value
                                                                      .radioValue,
                                                                  onChanged:
                                                                      (value) {
                                                                    provider
                                                                        .valueRadio0();
                                                                  })),
                                                      Text(
                                                        "Grup",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 50,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Consumer<
                                                              ChatRoomController>(
                                                          builder: (context,
                                                                  value,
                                                                  child) =>
                                                              Radio<int>(
                                                                activeColor:
                                                                    Colors.grey,
                                                                value: 1,
                                                                groupValue: value
                                                                    .radioValue,
                                                                onChanged:
                                                                    (value) {
                                                                  provider
                                                                      .valueRadio1();
                                                                },
                                                              )),
                                                      Text(
                                                        "Users",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.search,
                                                color: Colors.grey.shade400,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: 35,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 5),
                                                    child: Consumer<
                                                            ChatRoomController>(
                                                        builder:
                                                            (context, value,
                                                                    child) =>
                                                                TextFormField(
                                                                  cursorColor:
                                                                      mainColor,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey),
                                                                  onChanged:
                                                                      (value) {
                                                                    provider
                                                                        .searchFuntion(
                                                                            value);
                                                                  },
                                                                  controller: value
                                                                      .searchController,
                                                                  textAlignVertical:
                                                                      TextAlignVertical
                                                                          .top,
                                                                  decoration: InputDecoration(
                                                                      focusedBorder: UnderlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color:
                                                                                  mainColor)),
                                                                      border: UnderlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color:
                                                                                  mainColor)),
                                                                      hintStyle: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontStyle: FontStyle
                                                                              .italic),
                                                                      hintText:
                                                                          "Search",
                                                                      contentPadding:
                                                                          EdgeInsets.only(
                                                                              bottom: 15)),
                                                                )),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Consumer<ChatRoomController>(
                                              builder:
                                                  (context, value, child) =>
                                                      AnimatedSwitcher(
                                                          duration: Duration(
                                                              milliseconds:
                                                                  500),
                                                          child: value.isGroup
                                                              ? LimitedBox(
                                                                  maxHeight:
                                                                      300,
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .orange
                                                                            .shade50,
                                                                        borderRadius:
                                                                            BorderRadius.circular(16)),
                                                                    child: ListView.builder(
                                                                        padding: EdgeInsets.all(0),
                                                                        shrinkWrap: true,
                                                                        itemCount: value.departments.length,
                                                                        itemBuilder: (context, index) {
                                                                          if (value
                                                                              .textInput
                                                                              .isEmpty) {
                                                                            return listOfGroup(value.departments[index],
                                                                                index);
                                                                          }
                                                                          if (value
                                                                              .departments[index]
                                                                              .toString()
                                                                              .toLowerCase()
                                                                              .contains(value.textInput.toLowerCase())) {
                                                                            return listOfGroup(value.departments[index],
                                                                                index);
                                                                          }
                                                                          return SizedBox();
                                                                        }),
                                                                  ),
                                                                )
                                                              : LimitedBox(
                                                                  maxHeight:
                                                                      300,
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .orange
                                                                            .shade50,
                                                                        borderRadius:
                                                                            BorderRadius.circular(16)),
                                                                    child: ListView.builder(
                                                                        padding: EdgeInsets.all(0),
                                                                        shrinkWrap: true,
                                                                        itemCount: value.names.length,
                                                                        itemBuilder: (context, index) {
                                                                          if (value
                                                                              .textInput
                                                                              .isEmpty) {
                                                                            return listOfEmployee(
                                                                                context,
                                                                                value.names[index],
                                                                                value.emailList[index],
                                                                                index);
                                                                          }
                                                                          if (value
                                                                              .names[index]
                                                                              .toString()
                                                                              .toLowerCase()
                                                                              .contains(value.textInput.toLowerCase())) {
                                                                            return listOfEmployee(
                                                                                context,
                                                                                value.names[index],
                                                                                value.emailList[index],
                                                                                index);
                                                                          }
                                                                          return SizedBox();
                                                                        }),
                                                                  ),
                                                                ))),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Container(
                                              height: 30,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  OutlinedButton(
                                                      style: OutlinedButton.styleFrom(
                                                          fixedSize: Size(
                                                              Get.width * 0.25,
                                                              Get.height *
                                                                  0.025),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16)),
                                                          foregroundColor:
                                                              mainColor),
                                                      onPressed: () async {
                                                        Navigator.pop(context);
                                                        provider
                                                            .clearListAssign();
                                                      },
                                                      child: Text("Cancel")),
                                                  Consumer<ChatRoomController>(
                                                      builder: (context, value,
                                                              child) =>
                                                          ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  elevation: 0,
                                                                  fixedSize: Size(
                                                                      Get.width *
                                                                          0.25,
                                                                      Get.height *
                                                                          0.025),
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16)),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .orange),
                                                              onPressed: () {
                                                                if (value
                                                                    .departmentsAndNamesSelected
                                                                    .isEmpty) {
                                                                  Fluttertoast.showToast(
                                                                      msg:
                                                                          "Please Select Receiver",
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white,
                                                                      textColor:
                                                                          Colors
                                                                              .black);
                                                                } else {
                                                                  provider.assign(
                                                                      context,
                                                                      taskId,
                                                                      emailSender,
                                                                      location,
                                                                      title,
                                                                      scroll);
                                                                }
                                                              },
                                                              child: Text(
                                                                  "Assign")))
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                          )),
                ));
      });
}
