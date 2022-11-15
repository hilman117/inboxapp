import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:post/Screens/create/create_request_controller.dart';
import 'package:post/Screens/create/widget/appbar.dart';
import 'package:post/Screens/create/widget/dialog_dept.dart';
import 'package:post/Screens/create/widget/dialog_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:post/service/theme.dart';
import 'package:provider/provider.dart';
import '../../controller/c_user.dart';
import 'widget/box_description.dart';
import 'widget/execute_buttons.dart';
import 'widget/general_form.dart';
import 'widget/input_locaton.dart';
import 'widget/schedule.dart';

class CreateRequest extends StatefulWidget {
  const CreateRequest({super.key});

  @override
  State<CreateRequest> createState() => _CreateRequestState();
}

class _CreateRequestState extends State<CreateRequest> {
  final cUser = Get.put(CUser());

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        Provider.of<CreateRequestController>(context, listen: false)
            .clearData();
        Provider.of<CreateRequestController>(context, listen: false)
            .clearImage();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double widht = Get.width;
    double height = Get.height;
    final provider =
        Provider.of<CreateRequestController>(context, listen: false);
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
            height: height * 0.05,
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
                          titleList(context);
                        },
                        icons: Icons.arrow_drop_down_rounded,
                        colors: mainColor),
                    SizedBox(height: height * 0.010),
                    BoxDescription(
                      controller: Provider.of<CreateRequestController>(context)
                          .descriptionController,
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
                          Provider.of<CreateRequestController>(context)
                                      .images ==
                                  null
                              ? ExecuteButton().imageButton(context)
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: height * 0.1,
                                      width: widht * 0.2,
                                      child: Image.file(
                                          Provider.of<CreateRequestController>(
                                                  context)
                                              .images!,
                                          fit: BoxFit.cover),
                                    ),
                                    CloseButton(
                                      color: Colors.grey,
                                      onPressed: () =>
                                          Provider.of<CreateRequestController>(
                                                  context,
                                                  listen: false)
                                              .clearImage(),
                                    )
                                  ],
                                ),
                          SizedBox(height: height * 0.010),
                          ExecuteButton().sendButton(
                            context,
                            widht,
                            () {
                              if (value.isCreateRequest) {
                                Provider.of<CreateRequestController>(context,
                                        listen: false)
                                    .tasks(
                                        context,
                                        cUser.data.hotelid!,
                                        cUser.data.uid!,
                                        value.descriptionController,
                                        cUser.data.name!,
                                        cUser.data.department!,
                                        cUser.data.email!,
                                        value.selectedLocation.text);
                              } else {
                                provider.lfReport(
                                    context,
                                    cUser.data.hotelid!,
                                    cUser.data.uid!,
                                    value.descriptionController,
                                    cUser.data.name!,
                                    cUser.data.email!,
                                    value.selectedLocation.text);
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
