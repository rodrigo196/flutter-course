import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptativeFlatButton extends StatelessWidget {
  final String text;
  final Function handler;

  const AdaptativeFlatButton({@required this.text, @required this.handler});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: handler,
            child: Text(text),
          )
        : FlatButton(
            textColor: Theme.of(context).primaryColor,
            child: Text(text),
            onPressed: handler,
          );
  }
}
