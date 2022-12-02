import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:post/Screens/create/create_request_controller.dart';
import 'package:provider/provider.dart';

import 'tile_title.dart';

void titleList(BuildContext context, String tasksId, String emailSender) {
  showAnimatedDialog(
      alignment: Alignment.bottomCenter,
      barrierDismissible: true,
      duration: Duration(milliseconds: 500),
      animationType: DialogTransitionType.slideFromRight,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context, setState) => Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Center(
                    child: SingleChildScrollView(
                      child: AlertDialog(
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        content: Container(
                          // height: 500,
                          width: 500,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(50),
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 30,
                                      width: 30,
                                      decoration:
                                          BoxDecoration(shape: BoxShape.circle),
                                      child: CloseButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Predefined Request",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: 45,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Icon(
                                          Icons.search,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: TextFormField(
                                            controller: Provider.of<
                                                        CreateRequestController>(
                                                    context,
                                                    listen: false)
                                                .searchtitle,
                                            onChanged: (value) {
                                              Provider.of<CreateRequestController>(
                                                      context,
                                                      listen: false)
                                                  .setstate(value);
                                            },
                                            autofocus: false,
                                          ),
                                        ),
                                      ),
                                      Provider.of<CreateRequestController>(
                                                  context)
                                              .searchTitle
                                              .isEmpty
                                          ? Container()
                                          : CloseButton(
                                              color: Colors.grey,
                                              onPressed: () {
                                                Provider.of<CreateRequestController>(
                                                        context,
                                                        listen: false)
                                                    .clearSearchTitle();
                                              },
                                            )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              LimitedBox(
                                maxHeight: 500,
                                child: Container(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          Provider.of<CreateRequestController>(
                                                  context)
                                              .title
                                              .length,
                                      itemBuilder: (context, index) {
                                        print(Provider.of<
                                                    CreateRequestController>(
                                                context)
                                            .title[index]);
                                        List.generate(
                                            Provider.of<CreateRequestController>(
                                                    context)
                                                .title
                                                .length,
                                            (index) =>
                                                titleTile(context, index, tasksId, emailSender));
                                        if (Provider.of<
                                                    CreateRequestController>(
                                                context)
                                            .searchTitle
                                            .isEmpty) {
                                          return titleTile(context, index, tasksId, emailSender);
                                        }
                                        if (Provider.of<
                                                    CreateRequestController>(
                                                context)
                                            .title[index]
                                            .toString()
                                            .toLowerCase()
                                            .contains(Provider.of<
                                                        CreateRequestController>(
                                                    context)
                                                .searchTitle
                                                .toLowerCase())) {
                                          return titleTile(context, index, tasksId, emailSender);
                                        }
                                        return Container();
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
      });
}
