import 'package:chat_box/helper/helperfunction.dart';
import 'package:chat_box/services/auth.dart';
import 'package:chat_box/services/database.dart';
import 'package:chat_box/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chatroomscreen.dart';

class SignIn extends StatefulWidget {
  final Function toggleView1;
  SignIn(this.toggleView1);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //we can take the text from the TextField using the following
  TextEditingController emailTextEditingController1 =
      new TextEditingController();
  TextEditingController passwordTextEditingController1 =
      new TextEditingController();
  //now we will create the key in the following lines to validate the form
  final formKey = GlobalKey<FormState>();

  //we are creating a function so when the user clicks on the signin button, he/she knows that the button is doing something (it has been clicked)
  bool isLoading1 = false;
  //the following query snapshot facilitates to receive the query that the getUserByUseremail1 will return
  QuerySnapshot snapshotUserInfo1;

  signMeIn1() {
    if (formKey.currentState.validate()) {
      //the following line uses the authMethods1 object creadted below
      // the email and text are provided to this function using the text editing controllers created above
      authMethods1
          .signInWithEmailAndPassword1(emailTextEditingController1.text,
              passwordTextEditingController1.text)
          .then((val) {
        if (val != null) {
          //the following helps get the user data (here the username, which is saved as "name" under the database) using the email provided during signin using the below query
          databaseMethods1
              .getUserByUseremail1(emailTextEditingController1.text)
              .then((val) {
            snapshotUserInfo1 = val;
            HelperFunctions
                //we are using [0] since we know that only one user will have the given email
                .saveUserNameSharedPreference(
                    snapshotUserInfo1.documents[0].data["name"]);
          });

          //if the user is signed up successfully then the following saves his logged in status
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserEmailSharedPreference(
              emailTextEditingController1.text);

          //the following sets the state to loading, that is to let the user know something is happening by using the condition written in body of the scaffold
          setState(() {
            isLoading1 = true;
          });

          //the below line is used to navigate the user to the home page, we are using push replacement instead of push so that the user upon clicking the back button doesn't come back to the sign up page.
          //also as new route we are using the materialpageroute
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        }
      });
    }
  }

  AuthMethods1 authMethods1 = new AuthMethods1();
  HelperFunctions helperFunctions = new HelperFunctions();
  DatabaseMethods databaseMethods1 = new DatabaseMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain1(context),
      body: isLoading1
          //this is a simple true or false case programming, if the isLoading1 state is true the circular progress indicator is shown
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              //to avoid screen overflow
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Form(
                      key: formKey,
                      child: Column(children: [
                        TextFormField(
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val)
                                  ? null
                                  : "Please provide valid Email ID";
                            },
                            //the following line is used to extract text
                            controller: emailTextEditingController1,
                            decoration: textFieldInputDecoration('Email'),
                            style: simpleTextStyle1()),
                        TextFormField(
                            obscureText: true,
                            validator: (val) {
                              return val.length > 6
                                  ? null
                                  : "Please provide password 6+ characters";
                            },
                            //the following line is used to extract text
                            controller: passwordTextEditingController1,
                            decoration: textFieldInputDecoration('Password'),
                            style: simpleTextStyle1()),
                      ]),
                    ),

                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      //we are using this container so that when user wants to click on 'Forgot Password' , he can do it easily.
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          'Forgot Password?',
                          style: simpleTextStyle1(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    //instead of a floating button we are using a container
                    GestureDetector(
                      onTap: () {
                        signMeIn1();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xff007EF4),
                              const Color(0xff2A75BC),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          'Sign In',
                          style: simpleTextStyle1(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          'Sign in with Google',
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    //A row widget is being used here because we want the user to be able to select the Register now only
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have account?",
                          style: mediumTextStyle1(),
                        ),
                        GestureDetector(
                          onTap: () {
                            //now the toggle is in the super class not the sub class of sign in so to use that
                            widget.toggleView1();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Register Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
