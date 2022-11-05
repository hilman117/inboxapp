import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../service/theme.dart';
import '../create_request_controller.dart';

Widget appBarCreateTask(BuildContext context) {
  final provider = Provider.of<CreateRequestController>(context, listen: false);
  return Consumer<CreateRequestController>(
      builder: (context, value, child) => Row(
            children: [
              InkWell(
                onTap: () => provider.checkBoxCreateRequest(),
                child: SizedBox(
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: mainColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        value: value.isCreateRequest,
                        onChanged: (value) {
                          provider.checkBoxCreateRequest();
                        },
                      ),
                      Text(
                        "Create Request",
                        style: TextStyle(
                            color:
                                value.isCreateRequest ? mainColor : Colors.grey,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => provider.checkBoxLf(),
                child: SizedBox(
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: mainColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        value: value.isLfReport,
                        onChanged: (value) {
                          provider.checkBoxLf();
                        },
                      ),
                      Text(
                        "Lost And Found Report",
                        style: TextStyle(
                            color:
                                value.isCreateRequest ? Colors.grey : mainColor,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ));
}
