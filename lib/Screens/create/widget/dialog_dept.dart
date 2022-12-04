import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../dasboard/widget/card.dart';
import '../create_request_controller.dart';
import 'tile_dept.dart';

void sendToOption(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.center,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: Container(
            // height: 500,
            width: 500,
            child: Consumer<CreateRequestController>(
                builder: (context, value, child) => ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.departments.length,
                      itemBuilder: (context, index) {
                        return TileDept(
                            callback: () {
                              Provider.of<CreateRequestController>(context,
                                      listen: false)
                                  .selectDept(index);
                              Provider.of<CreateRequestController>(context,
                                      listen: false)
                                  .getTitle(
                                      cUser.data.hotelid!,
                                      Provider.of<CreateRequestController>(
                                              context,
                                              listen: false)
                                          .selectedDept);
                              Navigator.pop(context);
                            },
                            departement: value.departments[index]);
                      },
                    )),
          ),
        );
      });
}
