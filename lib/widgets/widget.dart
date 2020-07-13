import 'package:flutter/material.dart';

//widget to show same appbar with same logo on every screen
Widget appBarMain1(BuildContext context) {
  return AppBar(
    title: Image.asset(
      "assets/images/logo2.png",
      height: 50,
    ),
  );
}

//widget to style the input text field
InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.white54),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
  );
}

TextStyle simpleTextStyle1() {
  return TextStyle(color: Colors.white, fontSize: 16);
}

TextStyle mediumTextStyle1() {
  return TextStyle(color: Colors.white, fontSize: 17);
}
