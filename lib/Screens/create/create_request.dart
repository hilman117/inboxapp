import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:post/Screens/create/create_request_controller.dart';
import 'package:post/Screens/create/widget/appbar.dart';
import 'package:post/Screens/create/widget/dialog_dept.dart';
import 'package:post/Screens/create/widget/dialog_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:post/Screens/settings/setting_provider.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';
import '../../controller/c_user.dart';
import 'widget/box_description.dart';
import 'widget/execute_buttons.dart';
import 'widget/general_form.dart';
import 'widget/input_locaton.dart';
import 'widget/list_images.dart';
import 'widget/schedule.dart';

class CreateRequest extends StatefulWidget {
  const CreateRequest({super.key});

  @override
  State<CreateRequest> createState() => _CreateRequestState();
}

class _CreateRequestState extends State<CreateRequest> {
  final cUser = Get.put(CUser());
  var _idTask = 1 + Random().nextInt(2000);

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        Provider.of<CreateRequestController>(context, listen: false)
            .clearData();
        Provider.of<CreateRequestController>(context, listen: false)
            .clearSchedule();
        // Provider.of<CreateRequestController>(context, listen: false)
        //     .restartVariable();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double widht = Get.width;
    double height = Get.height;
    final provider =
        Provider.of<CreateRequestController>(context, listen: false);
    final landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 2,
                  offset: Offset(0.5, 0.5), // Shadow position
                ),
              ],
            ),
            alignment: Alignment.center,
            height: landscape ? height * 0.09 : height * 0.05,
            width: widht,
            child: CreateTaskAppBar()),
        centerTitle: true,
        titleTextStyle: const TextStyle(fontSize: 18),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<CreateRequestController>(context).isLodaing,
        progressIndicator: CircularProgressIndicator(
          color: secondary,
        ),
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Consumer<CreateRequestController>(
                builder: (context, value, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GeneralForm(
                        title: AppLocalizations.of(context)!.sendThisTo,
                        hintForm: value.selectedDept == 'Choose Department'
                            ? AppLocalizations.of(context)!.chooseDepartment
                            : value.selectedDept,
                        callback: () {
                          //form choose department....
                          sendToOption(context);
                        },
                        icons: Icons.arrow_drop_down_rounded,
                        colors: value.isLfReport ? Colors.grey : mainColor),
                    SizedBox(height: height * 0.010),
                    InputLocation(
                      callback: () {},
                    ),
                    SizedBox(height: height * 0.010),
                    GeneralForm(
                        title: value.isLfReport
                            ? 'Name of Item  '
                            : "${AppLocalizations.of(context)!.title}   ",
                        hintForm: value.selectedtitle == 'Input Title'
                            ? AppLocalizations.of(context)!.inputTitle
                            : value.selectedtitle,
                        callback: () async {
                          // // form choose title.....
                          provider.clearSearchTitle();
                          if (value.selectedDept == "Choose Department") {
                            Fluttertoast.showToast(
                                msg: AppLocalizations.of(context)!
                                    .noDepartementSelected,
                                backgroundColor: Colors.white,
                                textColor: mainColor);
                          } else {
                            titleList(context, '', "");
                          }
                        },
                        icons: Icons.arrow_drop_down_rounded,
                        colors: mainColor),
                    SizedBox(height: height * 0.010),
                    BoxDescription(
                      controller: value.descriptionController,
                    ),
                    SizedBox(height: height * 0.025),
                    SchedulePicker(),
                    SizedBox(height: height * 0.010),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.centerLeft,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.attachment,
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 15)),
                          SizedBox(height: height * 0.010),
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            switchInCurve: Curves.linear,
                            switchOutCurve: Curves.linear,
                            child: value.imagesList.isEmpty
                                ? Container(
                                    alignment: Alignment.centerLeft,
                                    // height: height * 0.1,
                                    child: ExecuteButton().imageButton(context))
                                : ListImages(),
                          ),
                          SizedBox(height: height * 0.010),
                          ExecuteButton().sendButton(
                            context,
                            widht,
                            () {
                              if (value.isCreateRequest) {
                                provider.tasks(
                                    Provider.of<SettingProvider>(context,
                                            listen: false)
                                        .imageUrl,
                                    context,
                                    cUser.data.hotelid!,
                                    cUser.data.uid!,
                                    value.descriptionController,
                                    cUser.data.name!,
                                    cUser.data.department!,
                                    cUser.data.email!,
                                    value.selectedLocation.text,
                                    _idTask.toString());
                              } else {
                                provider.lfReport(
                                    context,
                                    cUser.data.hotelid!,
                                    cUser.data.uid!,
                                    value.descriptionController,
                                    cUser.data.name!,
                                    cUser.data.email!,
                                    value.selectedLocation.text,
                                    value.descriptionController.text,
                                    _idTask.toString());
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
