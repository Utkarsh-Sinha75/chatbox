import 'package:chat_box/modal/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods1 {
  //every function created in here will have firebase auth used.
  //google pub.dev and search for firebase auth, go to installing tab and add the dependency in yaml file

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //using underscore makes it private, we are going to use user only under this class
  User _userFromFirebaseUser1(FirebaseUser user) {
    return user != null ? User(userId: user.uid) : null;
  }

  Future signInWithEmailAndPassword1(String email, String password) async {
    //we are using an error handling method below using try and catch, more can be learnt by watching this video "https://www.youtube.com/watch?v=HemchBJQdgM
    try {
      //await below is used to make sure that the next lines of code are executed only after we get the email and password verified
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebaseUser1(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPassword1(String email, String password) async {
    //we are using an error handling method below using try and catch, more can be learnt by watching this video "https://www.youtube.com/watch?v=HemchBJQdgM
    try {
      //await below is used to make sure that the next lines of code are executed only after we get the email and password verified
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebaseUser1(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetPass1(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

//signOut1 function is created by us but signOut comes with firebase_auth.dart package
  Future signOut1() async {
    try {
      return await _auth.signOut();
    } catch (e) {}
  }
}
