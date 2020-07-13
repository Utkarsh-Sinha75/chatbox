import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  //the below method asks to return only the data of the username we provided and not entire list
  getUserByUsername1(String username) async {
    return await Firestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .getDocuments();
  }

  //this function is used to update the user info in the database at the time of signup
  uploadUserInfo1(userMap1) {
    Firestore.instance.collection("users").add(userMap1).catchError((e) {
      print(e.toString());
    });
  }
}
