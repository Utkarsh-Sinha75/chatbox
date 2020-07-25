import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  //the below method asks to return only the data of the username we provided and not entire list
  getUserByUsername1(String username) async {
    return await Firestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .getDocuments();
  }

  getUserByUseremail1(String userEmail) async {
    return await Firestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        .getDocuments();
  }

  //this function is used to update the user info in the database at the time of signup
  uploadUserInfo1(userMap1) {
    Firestore.instance.collection("users").add(userMap1).catchError((e) {
      print(e.toString());
    });
  }

  //this function is used to create chatrooms in database
  createChatRoom(String chatRoomId, chatRoomMap) {
    Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .setData(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  //the following function adds the sent messages to the database when user clicks on send
  addConversationMessages(String chatRoomId, messageMap) {
    Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  //the following function gets the chats and shows them in real time on the screen
  getConversationMessages(String chatRoomId) async {
    return await Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        //the following line sorts the chats in the order they are sent
        .orderBy("time", descending: false)
        .snapshots();
  }

  //the following function helps show all the chats the user has on the chatroom screen
  getChatRooms(String userName) async {
    return await Firestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: userName)
        //we are using snapshot instead of getDocuments is because we want the chats to be synced on both sides, if one user deletes it, the other won't have it either
        .snapshots();
  }
}
