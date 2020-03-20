import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptativeDatePicker {
  final BuildContext context;

  AdaptativeDatePicker({@required this.context});

  void presentDatePicker(
      {@required DateTime initialDate,
      @required DateTime firstDate,
      @required DateTime lastDate,
      @required Function handler}) {
        
    showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: lastDate)
        .then((value) {
      handler(value);
    });
  }
}
