import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:post/Screens/homescreen/home.dart';
import 'package:post/Screens/sign_in/signin.dart';

class UserState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.data == null) {
            print('user is not signed in yet');
            return SignIn();
          } else if (userSnapshot.hasData) {
            print('user is already signed in');
            return Home();
          } else if (userSnapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Image.asset("images/error.png"),
              ),
            );
          } else if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          }
          return Scaffold(
            body: Center(
              child: Image.asset("images/error.png"),
            ),
          );
        });
  }
}
