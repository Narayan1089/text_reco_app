import 'dart:io';

import 'package:firebase_ml_text_recognition/widget/drawer.dart';
import 'package:firebase_ml_text_recognition/widget/preview_item.dart';
import 'package:flutter/material.dart';

class PreviewScreen extends StatelessWidget {
  final int id;
  final String text;
  final File image;

  PreviewScreen({this.id, this.text, this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Scanned Docs'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Total Items :$id',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5),
// The main issue here is to call the dynamic Listview Builder to update itself,
// but for that you have to use List or Map to store the user data and pass it down here

          Expanded(
            child: ListView(children: [
              PreviewItem(
                this.id,
                this.text,
                this.image,
              ),
            ]),
          )
        ],
      ),
      drawer: DrawerWidgets(),
    );
  }
}
