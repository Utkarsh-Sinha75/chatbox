import 'package:chat_box/helper/constants.dart';
import 'package:chat_box/services/database.dart';
import 'package:chat_box/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'conversation_screen.dart';

class SearchScreen1 extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<SearchScreen1> {
  TextEditingController searchTextEditingController =
      new TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  //the following takes the instance of query snapshot after search button is clicked using the initiate search function
  QuerySnapshot searchSnapshot;

  //the following method is created to initiate the search
  initiateSearch() {
    databaseMethods
        .getUserByUsername1(searchTextEditingController.text)
        .then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

//the following widget is created to show the search results in a list
  Widget searchList1() {
    return searchSnapshot != null
        ? ListView.builder(
            //the following returns the number of matched search items
            itemCount: searchSnapshot.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return searchTile1(
                //the "name" is the key and index is the search result index
                userName: searchSnapshot.documents[index].data["name"],
                userEmail: searchSnapshot.documents[index].data["email"],
              );
            })
        : Container();
  }

  //create chatroom, send user to conversation screen, push replacement
  createChatroomAndStartConversation1({String userName}) {
    //the following line is used during trail to see if myname is getting assigned the correct value or not
    print("${Constants1.myName1}");
    //we are using a function to create the chatroom id
    String chatRoomId = getChatRoomId(userName, Constants1.myName1);
    //the userName passed to the above function is the one we enter to search for a person and myName is taken from helper function
    List<String> users = [userName, Constants1.myName1];
    //when we create map the datatype of the key will be string but the value will be dynamic
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatRoomId": chatRoomId
    };

    DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ConversationScreen()));
  }

  Widget searchTile1({String userName, String userEmail}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            //the cross axis alignment is used to make all the elements of the container aligned
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: mediumTextStyle1()),
              Text(userEmail, style: mediumTextStyle1()),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatroomAndStartConversation1(userName: userName);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                "Message",
                style: mediumTextStyle1(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain1(context),
      body: Container(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            color: Color(0x54FFFFFF),
            child: Row(
              children: [
                //expanded widget gives the text field the space it needs and then allows the image to pop up
                Expanded(
                  child: TextField(
                    controller: searchTextEditingController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "Search username...",
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    initiateSearch();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          const Color(0x36FFFFFF),
                          const Color(0x0FFFFFFF),
                        ]),
                        borderRadius: BorderRadius.circular(40)),
                    padding: EdgeInsets.all(5),
                    child: Image.asset(
                      "assets/images/search-icon.png",
                    ),
                  ),
                )
              ],
            ),
          ),
          searchList1()
        ],
      )),
    );
  }
}

//the following function is implemented to make sure the chatroomid is unique for each combination of people chatting and is same for those two people chatting
getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
