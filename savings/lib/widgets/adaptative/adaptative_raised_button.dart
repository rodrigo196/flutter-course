import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptativeRaisedButton extends StatelessWidget {
  final String text;
  final Function handler;

  const AdaptativeRaisedButton({@required this.text, @required this.handler});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: handler,
            child: Text(
              text,
              style: Theme.of(context).textTheme.button,
            ),
            color: Theme.of(context).primaryColor,
          )
        : RaisedButton(
            textColor: Theme.of(context).textTheme.button.color,
            color: Theme.of(context).primaryColor,
            child: Text(text),
            onPressed: handler,
          );
  }
}
