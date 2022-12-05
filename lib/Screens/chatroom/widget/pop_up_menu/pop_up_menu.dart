import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:post/Screens/chatroom/chatroom_controller.dart';
import 'package:post/Screens/chatroom/widget/pop_up_menu/add_schedule.dart';
import 'package:post/Screens/chatroom/widget/pop_up_menu/dialog_location.dart';
import 'package:post/Screens/chatroom/widget/pop_up_menu/pop_up_menu_provider.dart';
import 'package:provider/provider.dart';

import '../../../create/create_request_controller.dart';
import '../../../create/widget/dialog_title.dart';
import '../../../dasboard/widget/card.dart';
import 'delete_schedule.dart';
import 'dialog_edit_schedule.dart';

void showPopUpMenu(BuildContext context, String selectedDept, String tasksId,
    String emailSender, String oldDate, String oldTime, String location) async {
  final app = AppLocalizations.of(context);
  final provider = Provider.of<CreateRequestController>(context, listen: false);
  final controller = Provider.of<ChatRoomController>(context, listen: false);
  double size = Get.height + Get.width;
  await showMenu(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      context: context,
      position: RelativeRect.fromLTRB(size * 0.02, size * 0.02, 0, size * 0.02),
      items: [
        if (provider.datePicked != '' || provider.selectedTime != '')
          PopupMenuItem(
            child: Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: Colors.grey.shade400,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(app!.editDueDate),
              ],
            ),
            value: 'Edit Due Date',
            onTap: () {
              Future.delayed(
                Duration.zero,
                () {
                  editSchedule(context, tasksId, emailSender, oldDate, oldTime,
                      location);
                },
              );
            },
          ),
        if (provider.datePicked != '' || provider.selectedTime != '')
          PopupMenuItem(
            child: Row(
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.grey.shade400,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(app!.deleteDueDate),
              ],
            ),
            value: 'Delete Due Date',
            onTap: () => Future.delayed(
                Duration.zero,
                () => deleteSchedule(
                    context, tasksId, emailSender, oldDate, oldTime, location)),
          ),
        if (provider.datePicked == '' || provider.selectedTime == '')
          PopupMenuItem(
            child: Row(
              children: [
                Icon(
                  Icons.add,
                  color: Colors.grey.shade400,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(app!.addDueDate),
              ],
            ),
            value: 'Add Due Date',
            onTap: () {
              Future.delayed(
                Duration.zero,
                () {
                  addSchedule(context, tasksId, emailSender, oldDate, oldTime,
                      location);
                },
              );
            },
          ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(
                controller.status != "Hold" ? Icons.pause : Icons.play_arrow,
                color: Colors.grey.shade400,
              ),
              SizedBox(
                width: 10,
              ),
              Text(controller.status != "Hold" ? app!.onHold : "Resume"),
            ],
          ),
          value: 'On Hold',
          onTap: controller.status != "Hold"
              ? () => Provider.of<PopUpMenuProvider>(context, listen: false)
                  .holdFunction(context, tasksId, emailSender, location)
              : () => Provider.of<PopUpMenuProvider>(context, listen: false)
                  .resumeFunction(context, tasksId, emailSender, location),
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(
                Icons.edit,
                color: Colors.grey.shade400,
              ),
              SizedBox(
                width: 10,
              ),
              Text(app!.editTitle),
            ],
          ),
          value: 'Edit title',
          onTap: () {
            Future.delayed(Duration.zero, () {
              Provider.of<PopUpMenuProvider>(context, listen: false)
                  .isChangeTitle(true);
              Provider.of<CreateRequestController>(context, listen: false)
                  .getTitle(cUser.data.hotelid!, selectedDept);
              titleList(context, tasksId, emailSender);
            });
          },
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(
                Icons.location_on_sharp,
                color: Colors.grey.shade400,
              ),
              SizedBox(
                width: 10,
              ),
              Text(app.editLocation),
            ],
          ),
          value: 'Edit location',
          onTap: () {
            Future.delayed(
              Duration.zero,
              () async {
                await Provider.of<CreateRequestController>(context,
                        listen: false)
                    .getLocation(cUser.data.hotelid!);
                listLoaction(context, tasksId, emailSender, location);
              },
            );
          },
        ),
      ]);
}
