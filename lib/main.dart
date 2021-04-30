import 'package:firebase_ml_text_recognition/providers/docs.dart';
import 'package:firebase_ml_text_recognition/screens/details.dart';
import 'package:firebase_ml_text_recognition/screens/preview_screen.dart';
import 'package:firebase_ml_text_recognition/widget/text_recognition_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/signin.dart';
import './screens/signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title = 'Text Recognition App';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DocsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.teal),
        home: SignUp(),
        routes: {
          MainPage.idScreen: (ctx) => MainPage(title: title),
          PreviewScreen.idScreen: (ctx) => PreviewScreen(),
          Details.idScreen: (ctx) => Details(),
          SignIn.idScreen: (ctx) => SignIn(),
          SignUp.idScreen: (ctx) => SignUp(),
        },
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final String title;
  static const String idScreen = '/MainPage';

  const MainPage({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.info,
              ),
              tooltip:
                  'This is ML mini project App, just a prototype, Not for Sale',
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(height: 25),
              TextRecognitionWidget(),
              const SizedBox(height: 15),
            ],
          ),
        ),
      );
}
