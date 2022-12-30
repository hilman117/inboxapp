import 'package:flutter/material.dart';
import 'package:post/Screens/chatroom/widget/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../../service/theme.dart';
import '../../../../../../../common_widget/card.dart';
import '../../../../../chatroom_controller.dart';

class TextFieldArea extends StatelessWidget {
  const TextFieldArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 0),
        height: height * 0.05,
        child: TextFormField(
          controller: Provider.of<ChatRoomController>(context, listen: false)
              .commentBody,
          cursorColor: mainColor,
          textAlignVertical: TextAlignVertical.center,
          cursorHeight: 14,
          onChanged: (value) {
            Provider.of<ChatRoomController>(context, listen: false)
                .typing(value);
          },
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          minLines: 1,
          maxLines: 5,
          style: const TextStyle(fontSize: 14, overflow: TextOverflow.clip),
          decoration: InputDecoration(
            isDense: true,
            border: InputBorder.none,
            hintText: AppLocalizations.of(context)!.typeHere,
            hintStyle: const TextStyle(fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
            prefixIcon: IconButton(
              onPressed: () {
                imagePicker(context, height, width);
              },
              icon: Icon(
                Icons.camera_alt_rounded,
                color: mainColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
