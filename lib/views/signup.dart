import 'package:chat_box/services/auth.dart';
import 'package:chat_box/services/database.dart';
import 'package:chat_box/views/chatroomscreen.dart';
import 'package:chat_box/widgets/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggleView1;
  SignUp(this.toggleView1);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //we can take the text from the TextField using the following

  TextEditingController userNameTextEditingController1 =
      new TextEditingController();
  TextEditingController emailTextEditingController1 =
      new TextEditingController();
  TextEditingController passwordTextEditingController1 =
      new TextEditingController();
  //now we will create the key in the following lines to validate the form
  final formKey = GlobalKey<FormState>();

  //we are creating a function so when the user clicks on the signup button, he/she knows that the button is doing something (it has been clicked)
  bool isLoading1 = false;

  //the following function helps check if the entered fields are correct(valid) or not
  signMeUp1() {
    if (formKey.currentState.validate()) {
      //we are creating a map to facilitate the upload of data in the database upon signup
      //also it is implemented on top of setState function because after isLoading is set to true the textbox becomes inactive
      Map<String, String> userMap1 = {
        "name": userNameTextEditingController1.text,
        "email": emailTextEditingController1.text,
      };

      //the following line uses the authMethods1 object creadted below
      // the email and text are provided to this function using the text editing controllers created above
      authMethods1
          .signUpWithEmailAndPassword1(emailTextEditingController1.text,
              passwordTextEditingController1.text)
          .then((val) {
        if (val != null) {
          //the following sets the state to loading, that is to let the user know something is happening by using the condition written in body of the scaffold
          setState(() {
            isLoading1 = true;
          });
          //below function is used to upload the user data in database using the above created map
          databaseMethods1.uploadUserInfo1(userMap1);
          //the below line is used to navigate the user to the home page, we are using push replacement instead of push so that the user upon clicking the back button doesn't come back to the sign up page.
          //also as new route we are using the materialpageroute
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        }
      });
    }
  }

  //now we will create an instance of AuthMethods class which we created in the auth.dart so we can use it on our signup page
  AuthMethods1 authMethods1 = new AuthMethods1();
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
                    //We are wrapping all the text fields into a column and turning them into a text form field so that we can validate the user
                    Form(
                      //now we will be providing a key for this form and then we can validate all the text fields inside this form which was created above
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                              //the following line provides a validator function that checks for a valid entry into the text field.
                              validator: (val) {
                                return val.isEmpty || val.length < 4
                                    ? "Please provide a valid username"
                                    : null;
                              },
                              //the following line is used to extract text
                              controller: userNameTextEditingController1,
                              decoration: textFieldInputDecoration('Username'),
                              style: simpleTextStyle1()),
                          TextFormField(
                              //the validator condition which we use here is verified by RegExp, we aren't using firebase to verify it in the first place
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
                              //the following is to make the password obscure
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
                        ],
                      ),
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
                    //The following widget ,that is the gesture detector is wrapping the container widget to provide an on tapped function
                    GestureDetector(
                      //the gesture detector has an on tap property which takes a function
                      onTap: () {
                        signMeUp1();
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
                          'Sign Up',
                          style: simpleTextStyle1(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'Sign Up with Google',
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have account?",
                          style: mediumTextStyle1(),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.toggleView1();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Sign in Now',
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
