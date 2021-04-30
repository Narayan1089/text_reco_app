import 'package:firebase_ml_text_recognition/main.dart';
import 'package:firebase_ml_text_recognition/providers/docs.dart';
import 'package:firebase_ml_text_recognition/widget/drawer.dart';
import 'package:firebase_ml_text_recognition/widget/preview_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreviewScreen extends StatelessWidget {
  static const String idScreen = '/PreviewScreen';

  // final int id;
  // final String text;
  // final File image;

  // PreviewScreen({this.id, this.text, this.image});

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<DocsProvider>(context);
    // final docsId = ModalRoute.of(context).settings.arguments as String;
    // final docsText = ModalRoute.of(context).settings.arguments as String;
    // final docsFile = ModalRoute.of(context).settings.arguments as File;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Scanned Docs'),
      ),
      body: Column(
        children: <Widget>[
          // Card(
          //   margin: EdgeInsets.all(15),
          //   child: Padding(
          //     padding: EdgeInsets.all(8),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: <Widget>[
          //         Text(
          //           'Total Items',
          //           style: TextStyle(fontSize: 20),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              itemCount: providerData.items.length,
              itemBuilder: (context, i) => providerData.items == null
                  ? Center(
                      child: Text('No Data foound'),
                    )
                  : PreviewItem(
                      providerData.items[i].id,
                      providerData.items[i].text,
                      providerData.items[i].image,
                    ),
            ),
          )
        ],
      ),
      drawer: DrawerWidgets(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(
                title: 'Text Recognition App',
              ),
            ),
          );
        },
        label: Text(
          'Scan Image',
          style: TextStyle(fontSize: 20),
        ),
        icon: Icon(Icons.camera_alt_outlined),
      ),
    );
  }
}
