import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/Screens/create/create_request_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../service/theme.dart';

Color themeColor = const Color(0xffF8CCA5);
Color cardColor = const Color(0xff475D5B);

class GeneralForm extends StatelessWidget {
  final String title;
  final String hintForm;
  final VoidCallback callback;
  final IconData icons;
  final Color colors;
  const GeneralForm(
      {super.key,
      required this.title,
      required this.hintForm,
      required this.callback,
      required this.icons,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    final landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Consumer<CreateRequestController>(
          builder: (context, value, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width * 0.25,
                child: Text(
                  value.isLfReport &&
                          title == AppLocalizations.of(context)!.sendThisTo
                      ? '- - - - - - '
                      : title,
                  style: TextStyle(
                      color: value.isLfReport &&
                              title == AppLocalizations.of(context)!.sendThisTo
                          ? Colors.black38
                          : Colors.black,
                      fontSize: 15),
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                // height: Get.height * 0.07,
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                          onTap: value.isLfReport &&
                                  title ==
                                      AppLocalizations.of(context)!.sendThisTo
                              ? null
                              : callback,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: landscape
                                ? Get.height * 0.1
                                : Get.height * 0.06,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius:
                                    BorderRadiusDirectional.circular(12)),
                            child: Row(
                              children: [
                                value.isLfReport
                                    ? Expanded(
                                        child: Container(
                                            child: value.isLfReport &&
                                                    title ==
                                                        AppLocalizations.of(
                                                                context)!
                                                            .sendThisTo
                                                ? Text(
                                                    '- - - - - - - - - - - - - - - - - - -',
                                                    style: const TextStyle(
                                                        color: Colors.black38,
                                                        fontSize: 15))
                                                : TextFormField(
                                                    controller: value.nameItem,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black54,
                                                    ),
                                                    cursorHeight: 14,
                                                    cursorColor: mainColor,
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    decoration: InputDecoration(
                                                        hintText: hintForm,
                                                        hintStyle: TextStyle(
                                                            color:
                                                                Colors.black38),
                                                        isDense: true,
                                                        border:
                                                            InputBorder.none),
                                                  )))
                                    : Text(
                                        hintForm,
                                        style: const TextStyle(
                                            color: Colors.black45),
                                      ),
                                value.isLfReport ? SizedBox() : Spacer(),
                                value.isLfReport &&
                                        title ==
                                            AppLocalizations.of(context)!
                                                .sendThisTo
                                    ? SizedBox()
                                    : Icon(
                                        icons,
                                        color: value.isLfReport &&
                                                title ==
                                                    AppLocalizations.of(
                                                            context)!
                                                        .sendThisTo
                                            ? Colors.grey
                                            : secondary,
                                        size: 20,
                                      ),
                              ],
                            ),
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
