import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/auth.dart';
import '../widget/widget.dart';

import '../services/database.dart';

import '../screens/preview_screen.dart';

class SignIn extends StatefulWidget {
  static const idScreen = '/signin';
  final Function toogleView;

  SignIn({this.toogleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthService authService = new AuthService();
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();

  // text feild
  bool _loading = false;
  String email = '', password = '', name = "";

  getInfoAndSignIn() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });

      await authService.signInEmailAndPass(email, password).then((value) {
        if (value != null) {
          setState(() {
            _loading = false;
          });
        }
        // Map<String, String> userInfo = {
        //   "userName": name,
        //   "email": email,
        // };

        // databaseService.addData(userInfo);

        // Constants.saveUserLoggedInSharedPreference(true);

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
                      child: Column(
                        children: [
                          // TextFormField(
                          //   validator: (val) =>
                          //       val.isEmpty ? "Enter an Name" : null,
                          //   decoration: InputDecoration(hintText: "Name"),
                          //   onChanged: (val) {
                          //     name = val;
                          //   },
                          // ),
                          // SizedBox(
                          //   height: 6,
                          // ),
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
                            height: 6,
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
                            height: 24,
                          ),
                          GestureDetector(
                            onTap: () {
                              getInfoAndSignIn();
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
                                "Sign In",
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
                              Text('Don\'t have an account? ',
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 17)),
                              GestureDetector(
                                onTap: () {
                                  widget.toogleView();
                                },
                                child: Container(
                                  child: Text('Sign Up',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          decoration: TextDecoration.underline,
                                          fontSize: 17)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
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

//   final AuthService _authService = AuthService();

//   TextEditingController emailEditingController = new TextEditingController();
//   TextEditingController passwordEditingController = new TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//         SystemUiOverlayStyle(statusBarColor: Colors.white));
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: AppLogo(),
//         brightness: Brightness.light,
//         elevation: 0.0,
//         backgroundColor: Colors.transparent,
//         //brightness: Brightness.li,
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 24),
//         child: Column(
//           children: [
//             Spacer(),
//             Container(
//               child: Column(
//                 children: [
//                   TextField(
//                     decoration: InputDecoration(hintText: "Email"),
//                   ),
//                   SizedBox(
//                     height: 6,
//                   ),
//                   TextField(
//                     decoration: InputDecoration(hintText: "Password"),
//                   ),
//                   SizedBox(
//                     height: 24,
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     width: MediaQuery.of(context).size.width,
//                     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//                     decoration: BoxDecoration(
//                         color: Colors.blue,
//                         borderRadius: BorderRadius.circular(30)),
//                     child: Text(
//                       "Sign In",
//                       style: TextStyle(fontSize: 16, color: Colors.white),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('Don\'t have an account? ',
//                           style:
//                               TextStyle(color: Colors.black87, fontSize: 17)),
//                       GestureDetector(
//                         onTap: () {
//                           widget.toogleView();
//                         },
//                         child: Container(
//                           child: Text('Sign Up',
//                               style: TextStyle(
//                                   color: Colors.black87,
//                                   decoration: TextDecoration.underline,
//                                   fontSize: 17)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 80,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
