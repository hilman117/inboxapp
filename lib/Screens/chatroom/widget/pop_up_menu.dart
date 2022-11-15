import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

void showPopUpMenu(BuildContext context) async {
  final app = AppLocalizations.of(context);
  double size = Get.height + Get.width;
  await showMenu(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      context: context,
      position: RelativeRect.fromLTRB(size * 0.02, size * 0.02, 0, size * 0.02),
      items: [
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
          onTap: () {},
        ),
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
              Text(app.deleteDueDate),
            ],
          ),
          value: 'Delete Due Date',
          onTap: () {},
        ),
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
              Text(app.addDueDate),
            ],
          ),
          value: 'Add Due Date',
          onTap: () {},
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(
                Icons.pause,
                color: Colors.grey.shade400,
              ),
              SizedBox(
                width: 10,
              ),
              Text(app.onHold),
            ],
          ),
          value: 'On Hold',
          onTap: () async {},
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
              Text(app.editTitle),
            ],
          ),
          value: 'Edit title',
          onTap: () async {},
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
          onTap: () async {},
        ),
      ]);
}
