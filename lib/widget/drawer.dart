import 'package:firebase_ml_text_recognition/main.dart';
import 'package:flutter/material.dart';

class DrawerWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  backgroundImage: AssetImage('images/Tushar.png'),
                  radius: 50,
                ),
                SizedBox(height: 10),
                Text(
                  'Welcome Tushar',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(color: Colors.white24),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Saved Items',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Update the state of the app.
              Navigator.of(context).pop();
            },
          ),
          Divider(),
          ListTile(
            title: Text(
              'Scan Files',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Update the state of the app.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(
                    title: 'Text Recognition App',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
