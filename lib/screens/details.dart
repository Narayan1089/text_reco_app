import 'package:firebase_ml_text_recognition/providers/docs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Details extends StatelessWidget {
  static const String idScreen = '/Details';
  @override
  Widget build(BuildContext context) {
    final idDetail = ModalRoute.of(context).settings.arguments as String;
    final detailText =
        Provider.of<DocsProvider>(context, listen: false).findbyId(idDetail);
    print(detailText.text);

    return Scaffold(
      appBar: AppBar(
        title: Text('Description'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(2),
              width: double.infinity,
              child: Center(
                child: Text(
                  'Image',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              height: 200,
              width: double.infinity,
              child: Image.file(detailText.image),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(2),
              width: double.infinity,
              child: Center(
                child: Text(
                  'Scanned Output',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(width: 5, color: Colors.grey),
                ),
                height: 280,
                width: double.infinity,
                child: Center(
                  child: Text(
                    detailText.text.toUpperCase().trim(),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
