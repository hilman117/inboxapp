import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post/common_widget/card.dart';
import 'package:post/service/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchOnAppBar extends StatelessWidget {
  const SearchOnAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.7,
      height: height * 0.04,
      decoration: BoxDecoration(
          color: mainColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4)),
      child: TextField(
        cursorColor: mainColor,
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
