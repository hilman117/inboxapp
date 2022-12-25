import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post/Screens/dasboard/widget/card.dart';
import 'package:post/Screens/homescreen/home_controller.dart';
import 'package:post/service/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SearchHome extends StatelessWidget {
  const SearchHome({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context, listen: false);
    return Container(
      width: width * 0.65,
      height: height * 0.04,
      decoration: BoxDecoration(
          color: mainColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4)),
      child: TextField(
        controller: controller.text,
        cursorColor: mainColor,
        onChanged: (text) {
          controller.getInputTextSearch(text);
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 10),
            prefixIcon: Icon(
              CupertinoIcons.search,
              size: 20,
              color: Colors.grey,
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: 35,
              minHeight: 35,
            ),
            hintText: "${AppLocalizations.of(context)!.search}",
            border: InputBorder.none),
      ),
    );
  }
}
