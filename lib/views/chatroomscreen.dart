import 'package:chat_box/helper/authenticate.dart';
import 'package:chat_box/services/auth.dart';
import 'package:chat_box/views/search.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  //creating instance of the authmethod created in auth.dart
  AuthMethods1 authMethods1 = new AuthMethods1();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/logo2.png",
          height: 50,
        ),
        //the following code is used to assign buttons to the appbar
        actions: [
          GestureDetector(
            onTap: () {
              authMethods1.signOut1();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Authenticate(),
                  ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchScreen1()),
            );
          }),
    );
  }
}
