import 'dart:io';

import 'package:firebase_ml_text_recognition/models/document.dart';
import 'package:flutter/cupertino.dart';

class DocsProvider extends ChangeNotifier {
  List<Document> _items = [];

  List<Document> get items {
    return [..._items];
  }

  Document findbyId(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void addItems(String id, String text, File image) {
    final newItems = Document(
      id: id,
      text: text,
      image: image,
    );
    _items.add(newItems);

    notifyListeners();
  }
}
