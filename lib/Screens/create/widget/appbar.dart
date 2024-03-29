import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../service/theme.dart';
import '../create_request_controller.dart';

class CreateTaskAppBar extends StatelessWidget {
  const CreateTaskAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<CreateRequestController>(context, listen: false);
    return Consumer<CreateRequestController>(
        builder: (context, value, child) => Row(
              children: [
                InkWell(
                  onTap: () => provider.checkBoxCreateRequest(),
                  child: SizedBox(
                    child: Row(
                      children: [
                        Checkbox(
                          activeColor: secondary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          value: value.isCreateRequest,
                          onChanged: (value) {
                            provider.checkBoxCreateRequest();
                          },
                        ),
                        Text(
                          AppLocalizations.of(context)!.createRequest,
                          style: TextStyle(
                              color: value.isCreateRequest
                                  ? secondary
                                  : Colors.grey,
                              fontSize: 12),
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
                          activeColor: secondary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          value: value.isLfReport,
                          onChanged: (value) {
                            provider.checkBoxLf();
                          },
                        ),
                        SizedBox(
                          // width: width * 0.5,
                          child: Text(
                            "Lost And Found Report",
                            style: TextStyle(
                                color: value.isCreateRequest
                                    ? Colors.grey
                                    : secondary,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ));
  }
}
