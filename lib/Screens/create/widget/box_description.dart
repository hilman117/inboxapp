import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../service/theme.dart';

class BoxDescription extends StatelessWidget {
  final TextEditingController controller;
  const BoxDescription({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.description,
              style: const TextStyle(color: Colors.black, fontSize: 15)),
          SizedBox(height: Get.height * 0.01),
          Container(
            height: landscape ? Get.height * 0.3 : Get.height * 0.13,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              child: TextFormField(
                style: TextStyle(fontSize: 16),
                cursorHeight: 17,
                cursorColor: mainColor.withOpacity(0.5),
                controller: controller,
                textInputAction: TextInputAction.newline,
                maxLines: null,
                minLines: 1,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 8),
                    hintText: AppLocalizations.of(context)!.typeHere,
                    hintStyle: const TextStyle(overflow: TextOverflow.clip),
                    border: InputBorder.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
