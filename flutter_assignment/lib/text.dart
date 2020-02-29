import 'package:flutter/material.dart';

class MyText extends StatelessWidget {

  final String message;

  MyText(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          color: Colors.blue,
        ),
      ),
    );
  }
}
