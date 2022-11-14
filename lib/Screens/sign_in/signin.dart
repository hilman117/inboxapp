import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:post/Screens/sign_in/sign_in_controller.dart';
import 'package:provider/provider.dart';

import '../../service/theme.dart';
import 'widget/form.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late TextEditingController emailC = TextEditingController(
      text: Provider.of<SignInController>(context).getEmail);
  late TextEditingController passwordC = TextEditingController(
      text: Provider.of<SignInController>(context).getPassword);
  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SignInController>(context, listen: false);
    double width = Get.width;
    double height = Get.height;
    return Consumer<SignInController>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
            inAsyncCall: value.isLoading,
            progressIndicator: CircularProgressIndicator(
              color: mainColor,
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "images/launcher4.png",
                        width: width * 0.50,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        height: height * 0.007,
                      ),
                      Text(
                        "Hotel Internal Messaging System",
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                      SizedBox(
                        height: height * 0.047,
                      ),
                      InputForm(
                          icon: Icons.alternate_email_rounded,
                          hintText: AppLocalizations.of(context)!.email,
                          controller: emailC,
                          action: TextInputAction.next,
                          callback: () {},
                          textInputType: TextInputType.emailAddress,
                          isObsecure: false),
                      SizedBox(
                        height: height * 0.012,
                      ),
                      InputForm(
                          icon: value.isObsecure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          controller: passwordC,
                          hintText: AppLocalizations.of(context)!.password,
                          isObsecure: value.isObsecure,
                          callback: () => controller.obsecure(),
                          textInputType: TextInputType.visiblePassword,
                          action: TextInputAction.done),
                      SizedBox(
                        height: height * 0.016,
                      ),
                      SizedBox(
                        child: Consumer<SignInController>(
                            builder: (context, value, child) => Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await controller
                                            .isSaveValue(value.isSave);
                                        print(
                                            "check box value is ${value.isSave}");
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: height * 0.025,
                                        width: width * 0.055,
                                        decoration: BoxDecoration(
                                            color: value.isSave
                                                ? mainColor
                                                : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            border: Border.all(
                                                color:
                                                    mainColor.withOpacity(0.2),
                                                width: 1.5)),
                                        child: value.isSave
                                            ? Icon(
                                                Icons.check,
                                                size: 15,
                                                color: Colors.white,
                                              )
                                            : SizedBox(),
                                      ),
                                    ),
                                    SizedBox(width: width * 0.03),
                                    Text(
                                        AppLocalizations.of(context)!
                                            .alwaysRememberMe,
                                        style: GoogleFonts.poppins(
                                            color: Colors.black))
                                  ],
                                )),
                      ),
                      SizedBox(
                        height: height * 0.050,
                      ),
                      SizedBox(
                        height: height * 0.06,
                        width: width,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                side: BorderSide(color: mainColor, width: 0.5),
                                backgroundColor: mainColor),
                            onPressed: () =>
                                controller.signIn(emailC.text, passwordC.text),
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: GoogleFonts.poppins(color: Colors.white),
                            )),
                      ),
                      SizedBox(
                        height: height * 0.050,
                      ),
                      Text(
                        AppLocalizations.of(context)!.register,
                        style: GoogleFonts.poppins(
                            fontSize: 13, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: height * 0.030,
                      ),
                      const Text(
                        "Version 0.0.1",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: height * 0.050,
                      ),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       Get.to(SignUp());
                      //     },
                      //     child: const Text("Register"))
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
