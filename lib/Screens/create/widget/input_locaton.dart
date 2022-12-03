import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:post/Screens/create/create_request_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../service/theme.dart';

class InputLocation extends StatelessWidget {
  final VoidCallback callback;
  const InputLocation({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.center,
        width: double.infinity,
        height: Get.height * 0.09,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width * 0.25,
              child: Text(
                "${AppLocalizations.of(context)!.location}:   ",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10)),
                height: Get.height * 0.07,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 9),
                      width: Get.width * 0.75,
                      child: TypeAheadFormField<String>(
                        debounceDuration: Duration(milliseconds: 0),
                        hideOnEmpty: true,
                        animationStart: 0,
                        animationDuration: Duration(milliseconds: 0),
                        textFieldConfiguration: TextFieldConfiguration(
                            cursorColor: mainColor.withOpacity(0.5),
                            style: const TextStyle(
                                fontSize: 15, color: Colors.black45),
                            autofocus: false,
                            textAlignVertical: TextAlignVertical.center,
                            controller:
                                Provider.of<CreateRequestController>(context)
                                    .selectedLocation,
                            decoration: InputDecoration(
                                isDense: true,
                                hintStyle: TextStyle(color: Colors.black38),
                                hintText:
                                    AppLocalizations.of(context)!.typeLocation,
                                contentPadding: EdgeInsets.only(top: 11),
                                border: InputBorder.none)),
                        suggestionsCallback: (pattern) async {
                          return await Provider.of<CreateRequestController>(
                                  context,
                                  listen: false)
                              .searchLocation(pattern);
                        },
                        itemBuilder: (context, suggestion) {
                          return Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5, color: Colors.grey)),
                            ),
                            child: Text(
                              suggestion,
                              style: const TextStyle(fontSize: 15),
                            ),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          Provider.of<CreateRequestController>(context,
                                  listen: false)
                              .selectLocation(suggestion);
                        },
                      ),
                    ),
                    Spacer(),
                    Image.asset(
                      'images/location.png',
                      width: 19,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
