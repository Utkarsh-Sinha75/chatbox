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

  String giveChatsAName(String chatID, String userName) {
    List chatIDNew = chatID.split('_');
    String first = chatIDNew[0];
    String second = chatIDNew[1];

    first = first.replaceAll(userName, '');
    second = second.replaceAll(userName, '');

    if (first == '') {
      return chatIDNew[1];
    } else {
      return chatIDNew[0];
    }
  }

  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  String name = giveChatsAName(
                      snapshot.data.documents[index].data["chatRoomId"]
                          .toString(),
                      Constants1.myName1);
                  return ChatRoomTile(
                      name, snapshot.data.documents[index].data["chatRoomId"]);
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
    Constants1.myEmail1 = await HelperFunctions.getUserEmailSharedPreference();
    //print("${Constants1.myLog1}");
    //print("${Constants1.myName1}");
    databaseMethods.getChatRooms(Constants1.myName1).then((value) {
      setState(() {
        chatRoomStream = value;
      });
    });
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
              HelperFunctions.removeValues();
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
