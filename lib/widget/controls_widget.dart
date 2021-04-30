import 'package:flutter/material.dart';

class ControlsWidget extends StatelessWidget {
  final VoidCallback onClickedPickImage;
  final VoidCallback onClickedScanText;
  final VoidCallback onClickedClear;

  const ControlsWidget({
    @required this.onClickedPickImage,
    @required this.onClickedScanText,
    @required this.onClickedClear,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            onPressed: onClickedPickImage,
            color: Colors.orange,
            child: Text(
              'Choose Image',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 6),
          RaisedButton(
            onPressed: onClickedScanText,
            color: Colors.green,
            child: Text(
              'Scan For Text',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            focusElevation: 60,
          ),
          const SizedBox(width: 6),
          RaisedButton(
            onPressed: onClickedClear,
            color: Colors.red,
            child: Text(
              'Clear',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            focusElevation: 60,
            hoverColor: Colors.amber,
          )
        ],
      );
}
