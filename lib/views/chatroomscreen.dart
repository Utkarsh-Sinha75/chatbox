import 'package:chat_box/helper/authenticate.dart';
import 'package:chat_box/helper/constants.dart';
import 'package:chat_box/helper/helperfunction.dart';
import 'package:chat_box/services/auth.dart';
import 'package:chat_box/services/database.dart';
import 'package:chat_box/views/conversation_screen.dart';
import 'package:chat_box/views/search.dart';
import 'package:chat_box/widgets/widget.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  //creating instance of the authmethod created in auth.dart
  AuthMethods1 authMethods1 = new AuthMethods1();
  DatabaseMethods databaseMethods = new DatabaseMethods();
//the following stream helps in showing all the chats
  Stream chatRoomStream;

  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return ChatRoomTile(
                      snapshot.data.documents[index].data["chatRoomId"]
                          //the following two lines help separate the username of the other person from the chatroomId
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(Constants1.myName1, ""),
                      snapshot.data.documents[index].data["chatRoomId"]);
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo1();
    super.initState();
  }

  getUserInfo1() async {
    Constants1.myName1 = await HelperFunctions.getUserNameSharedPreference();
    print("${Constants1.myName1}");
    databaseMethods.getChatRooms(Constants1.myName1).then((value) {
      setState(() {
        chatRoomStream = value;
      });
    });
    setState(() {});
  }

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
      body: chatRoomList(),
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

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  ChatRoomTile(this.userName, this.chatRoomId);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationScreen(chatRoomId)));
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                "${userName.substring(0, 1).toUpperCase()}",
                style: mediumTextStyle1(),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              userName,
              style: mediumTextStyle1(),
            )
          ],
        ),
      ),
    );
  }
}
