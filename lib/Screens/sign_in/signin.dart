import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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
    double widht = Get.width;
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/launcher4.png",
                      width: widht * 0.50,
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
                    signInForm(
                        Icons.alternate_email_rounded,
                        emailC,
                        "Email",
                        false,
                        () {},
                        TextInputType.emailAddress,
                        TextInputAction.next,
                        context,
                        Colors.orange),
                    SizedBox(
                      height: height * 0.012,
                    ),
                    signInForm(
                        value.isObsecure
                            ? Icons.visibility_off
                            : Icons.visibility,
                        passwordC,
                        "Password",
                        value.isObsecure,
                        () => controller.obsecure(),
                        TextInputType.visiblePassword,
                        TextInputAction.next,
                        context,
                        Colors.orange),

                    SizedBox(
                      child: Consumer<SignInController>(
                          builder: (context, value, child) => Row(
                                children: [
                                  Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    activeColor: mainColor,
                                    value: value.isSave,
                                    onChanged: (bool) async {
                                      await controller.isSaveValue(bool!);
                                      print(
                                          "check box value is ${value.isSave}");
                                    },
                                  ),
                                  Text("Remember me?",
                                      style: TextStyle(
                                          color: value.isSave
                                              ? mainColor
                                              : Colors.grey))
                                ],
                              )),
                    ),
                    SizedBox(
                      height: height * 0.050,
                    ),
                    SizedBox(
                      height: height * 0.045,
                      width: widht * 0.8,
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
                            "Log in",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    SizedBox(
                      height: height * 0.050,
                    ),
                    const Text(
                      "Register your property by contact us at support@post.com",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: height * 0.050,
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
            )),
      ),
    );
  }
}
