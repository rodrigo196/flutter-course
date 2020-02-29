import 'package:flutter/material.dart';

class TextControl extends StatelessWidget {
  final Function changeMessageHandler;

  TextControl(this.changeMessageHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        child: Text(
          "Change message!",
        ),
        onPressed: changeMessageHandler,
      ),
    );
  }
}
