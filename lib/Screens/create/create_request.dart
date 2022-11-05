import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:post/Screens/create/create_request_controller.dart';
import 'package:post/Screens/create/widget/appbar.dart';
import 'package:post/Screens/create/widget/dialog_dept.dart';
import 'package:post/Screens/create/widget/dialog_title.dart';
import 'package:provider/provider.dart';
import '../../controller/c_user.dart';
import 'widget/box_description.dart';
import 'widget/execute_buttons.dart';
import 'widget/form.dart';
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
            .clearSelectedDept();
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
            child: appBarCreateTask(context)),
        centerTitle: true,
        titleTextStyle: const TextStyle(fontSize: 18),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<CreateRequestController>(context).isLodaing,
        progressIndicator: CircularProgressIndicator(
          color: Colors.orange,
        ),
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Consumer<CreateRequestController>(
                builder: (context, value, child) => Column(
                  children: [
                    AnimatedContainer(
                      curve: Curves.easeInOutSine,
                      duration: Duration(milliseconds: 320),
                      height: value.isLfReport ? height * 0.05 : height * 0.11,
                      child: Stack(
                        children: [
                          GeneralForm(
                              title: "Send this task to:",
                              hintForm: value.selectedDept,
                              callback: () {
                                //form choose department....
                                sendToOption(context);
                              },
                              icons: Icons.arrow_drop_down_rounded),
                          AnimatedPadding(
                              curve: Curves.easeInOutSine,
                              padding: EdgeInsets.only(
                                  top: value.isLfReport
                                      ? height * 0.0
                                      : height * 0.06),
                              duration: Duration(milliseconds: 300),
                              child:
                                  inputLocation(widht, height, () {}, context)),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.010),
                    GeneralForm(
                        title:
                            value.isLfReport ? 'Name of Item:  ' : "Title:   ",
                        hintForm: value.selectedtitle,
                        callback: () async {
                          // // form choose title.....
                          provider.clearSearchTitle();
                          titleList(context);
                        },
                        icons: Icons.list),
                    SizedBox(height: height * 0.010),
                    boxDescription(
                        Provider.of<CreateRequestController>(context)
                            .descriptionController,
                        height,
                        "Description..."),
                    SizedBox(height: height * 0.025),
                    AnimatedContainer(
                        height: value.isLfReport ? height * 0.1 : height * 0.15,
                        duration: Duration(milliseconds: 300),
                        child: Stack(
                          children: [
                            AnimatedOpacity(
                                duration: Duration(milliseconds: 200),
                                opacity: value.isLfReport ? 0.0 : 1.0,
                                child: schedulePicker(context, height, widht)),
                            AnimatedPadding(
                              duration: Duration(milliseconds: 300),
                              padding: EdgeInsets.only(
                                  top: value.isLfReport
                                      ? height * 0.0
                                      : height * 0.1),
                              child: Container(
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Provider.of<CreateRequestController>(
                                                    context)
                                                .images ==
                                            null
                                        ? ExecuteButton().imageButton(context)
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                onPressed: () => Provider.of<
                                                            CreateRequestController>(
                                                        context,
                                                        listen: false)
                                                    .clearImage(),
                                              )
                                            ],
                                          ),
                                    ExecuteButton().sendButton(
                                      context,
                                      widht,
                                      () {
                                        if (value.isCreateRequest) {
                                          Provider.of<CreateRequestController>(
                                                  context,
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
                            )
                          ],
                        )),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
