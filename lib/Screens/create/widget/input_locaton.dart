import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:post/Screens/create/create_request_controller.dart';
import 'package:provider/provider.dart';

import '../../../service/theme.dart';

Widget inputLocation(
    double widht, double height, VoidCallback callback, BuildContext context) {
  return InkWell(
    onTap: callback,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      width: double.infinity,
      height: height * 0.05,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: widht * 0.25,
            child: Text(
              "Location:   ",
              style: TextStyle(color: Colors.black54, fontSize: 15),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Color(0xffF5F5F5),
                  borderRadius: BorderRadius.circular(10)),
              height: height * 0.05,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 9),
                    width: widht * 0.55,
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
                              hintStyle: TextStyle(color: Colors.black45),
                              hintText: 'type location..',
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
                                bottom:
                                    BorderSide(width: 0.5, color: Colors.grey)),
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
                  Icon(
                    Icons.location_on,
                    color: mainColor,
                    size: 20,
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
