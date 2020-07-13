import 'package:chat_box/views/signin.dart';
import 'package:chat_box/views/signup.dart';
import 'package:flutter/material.dart';

//this dart file facilitates between switching between the signin and signup screens

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn1 = true;
  //function to switch between the signin and signup screens
  void toggleView1() {
    setState(() {
      showSignIn1 = !showSignIn1;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn1) {
      return SignIn(toggleView1);
    } else {
      return SignUp(toggleView1);
    }
  }
}
