import 'package:firebase_ml_text_recognition/screens/preview_screen.dart';
import 'package:firebase_ml_text_recognition/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../helper/constants.dart';
import '../services/auth.dart';
import '../services/database.dart';

import '../widget/widget.dart';

class SignUp extends StatefulWidget {
  static const idScreen = '/signup';
  final Function toogleView;

  SignUp({this.toogleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthService authService = new AuthService();
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();

  // text feild
  bool _loading = false;
  String email = '', password = '', name = "";

  getInfoAndSignUp() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });

      await authService
          .signUpWithEmailAndPassword(email, password)
          .then((value) {
        Map<String, String> userInfo = {
          "userName": name,
          "email": email,
        };

        databaseService.addData(userInfo);

        Constants.saveUserLoggedInSharedPreference(true);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => PreviewScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: AppLogo(),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: _loading
            ? Container(
                child: Center(child: CircularProgressIndicator()),
              )
            : Column(
                children: [
                  Spacer(),
                  Form(
                    key: _formKey,
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? "Enter an Name" : null,
                              decoration: InputDecoration(hintText: "Name"),
                              onChanged: (val) {
                                name = val;
                              },
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            TextFormField(
                              validator: (val) => validateEmail(email)
                                  ? null
                                  : "Enter correct email",
                              decoration: InputDecoration(hintText: "Email"),
                              onChanged: (val) {
                                email = val;
                              },
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            TextFormField(
                              obscureText: true,
                              validator: (val) => val.length < 6
                                  ? "Password must be 6+ characters"
                                  : null,
                              decoration: InputDecoration(hintText: "Password"),
                              onChanged: (val) {
                                password = val;
                              },
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            GestureDetector(
                              onTap: () {
                                getInfoAndSignUp();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 20),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Already have and account? ',
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 17)),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignIn(),
                                      ),
                                    );
                                  },
                                  child: SingleChildScrollView(
                                    child: Container(
                                      child: Text('Sign In',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 17)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  )
                ],
              ),
      ),
    );
  }
}

bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}
