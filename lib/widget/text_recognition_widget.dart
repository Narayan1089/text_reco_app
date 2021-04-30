import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:firebase_ml_text_recognition/api/firebase_ml_api.dart';

import 'package:firebase_ml_text_recognition/providers/docs.dart';

import 'package:firebase_ml_text_recognition/widget/text_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

import 'controls_widget.dart';

class TextRecognitionWidget extends StatefulWidget {
  const TextRecognitionWidget({
    Key key,
  }) : super(key: key);

  @override
  _TextRecognitionWidgetState createState() => _TextRecognitionWidgetState();
}

class _TextRecognitionWidgetState extends State<TextRecognitionWidget> {
  String text = '';
  File image;
  String id = randomString(10);
  // var _editDocument = Document(id: null, text: '', image: null);

  // var _intializeValues = {
  //   'text': '',
  //   'image': null,
  // };
  void _saveItem() {
    Provider.of<DocsProvider>(context, listen: false).addItems(id, text, image);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // final String text2 = text;
    // final int id2 = id;
    // final File image2 = image;
    return Expanded(
      child: Column(
        children: [
          Expanded(child: buildImage()),
          const SizedBox(height: 8),
          ControlsWidget(
            onClickedPickImage: pickImage,
            onClickedScanText: scanText,
            onClickedClear: clear,
          ),
          const SizedBox(height: 8),
          TextAreaWidget(
            text: text,
            onClickedCopy: copyToClipboard,
          ),
          // Icon Button below for Saving and redirecting
          IconButton(
            icon: Icon(Icons.save_outlined),
            tooltip: 'Save File',
            onPressed: _saveItem,
          ),
        ],
      ),
    );
  }

  Widget buildImage() => Container(
        child: image != null
            ? Image.file(image)
            : Icon(Icons.photo, size: 80, color: Colors.black),
      );

  Future pickImage() async {
    final file = await ImagePicker().getImage(source: ImageSource.gallery);
    setImage(File(file.path));
  }

  Future scanText() async {
    showDialog(
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
      context: context,
    );

    final text = await FirebaseMLApi.recogniseText(image);
    setText(text);

    Navigator.of(context).pop();
  }

  void clear() {
    setImage(null);
    setText('');
  }

  void copyToClipboard() {
    if (text.trim() != '') {
      FlutterClipboard.copy(text);
    }
  }

  void setImage(File newImage) {
    setState(() {
      image = newImage;
    });
  }

  void setText(String newText) {
    setState(() {
      text = newText;
    });
  }
}
