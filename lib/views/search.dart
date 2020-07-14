import 'package:chat_box/services/database.dart';
import 'package:chat_box/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
              return SearchTile(
                //the "name" is the key and index is the search result index
                userName: searchSnapshot.documents[index].data["name"],
                userEmail: searchSnapshot.documents[index].data["email"],
              );
            })
        : Container();
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

//the following widget shows the search results in tile view
class SearchTile extends StatelessWidget {
  final String userName;
  final String userEmail;
  SearchTile({this.userName, this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Text(userName, style: simpleTextStyle1()),
              Text(userEmail, style: simpleTextStyle1()),
            ],
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text("Message"),
          ),
        ],
      ),
    );
  }
}
