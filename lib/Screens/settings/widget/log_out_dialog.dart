import 'package:flutter/material.dart';
import 'package:post/Screens/settings/setting_provider.dart';
import 'package:provider/provider.dart';

void logoutDialog(context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: Container(
            alignment: Alignment.center,
            height: 90,
            child: Column(
              children: [
                Text(
                  "Are you sure want to log out?",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel"),
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          foregroundColor: Colors.orange),
                    ),
                    SizedBox(width: 30),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<SettingProvider>(context, listen: false)
                            .signOut(context);
                      },
                      child: Text("Yes"),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.orange),
                    ),
                    // Container(
                    //   width: 90,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(20),
                    //   ),
                    //   child: ElevatedButton(
                    //       style: ElevatedButton.styleFrom(
                    //           primary: Color(0xff007dff),
                    //           shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(20))),
                    //       onPressed: () {
                    //         Navigator.pop(context);
                    //       },
                    //       child: Text(
                    //         "Cancel",
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.normal,
                    //             color: Colors.white),
                    //       )),
                    // ),
                    // Container(
                    //   width: 90,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(20),
                    //   ),
                    //   child: ElevatedButton(
                    //       style: ElevatedButton.styleFrom(
                    //           primary: Colors.white,
                    //           side: BorderSide(
                    //             color: Color(0xff007dff),
                    //           ),
                    //           shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(20))),
                    //       onPressed: () {
                    //         _auth.signOut();
                    //         Navigator.pushAndRemoveUntil(
                    //           context,
                    //           PageTransition(
                    //               child: SignIn(),
                    //               type: PageTransitionType.rightToLeft),
                    //           (Route<dynamic> route) => false,
                    //         );
                    //       },
                    //       child: Text(
                    //         "Yes",
                    //         style: TextStyle(
                    //           fontWeight: FontWeight.normal,
                    //           color: Color(0xff007dff),
                    //         ),
                    //       )),
                    // ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}
