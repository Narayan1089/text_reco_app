import 'dart:io';

import 'package:firebase_ml_text_recognition/screens/details.dart';
import 'package:flutter/material.dart';

class PreviewItem extends StatelessWidget {
  final String id;
  final String text;
  final File image;

  PreviewItem(
    this.id,
    this.text,
    this.image,
  );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text(
              'Do you want to remove the item from the cart?',
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {},
      child: GestureDetector(
          child: Card(
            margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4,
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: ListTile(
                leading: CircleAvatar(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(
                      child: image != null
                          ? Image.file(image)
                          : Icon(Icons.photo, size: 80, color: Colors.black),
                    ),
                  ),
                ),
                title:
                    // image != null
                    //     ? Text(
                    //         text,
                    //         maxLines: 4,
                    //         style: TextStyle(fontSize: 5),
                    //       )
                    //     :
                    Text(
                  'Decription',
                  style: TextStyle(fontSize: 20),
                ),

                // subtitle: Text('Total: \$${(price * quantity)}'),
                // trailing: Text('$quantity x'),
              ),
            ),
          ),
          onDoubleTap: () {
            Navigator.of(context).pushNamed(
              Details.idScreen,
              arguments: id,
            );
          }),
    );
  }
}
