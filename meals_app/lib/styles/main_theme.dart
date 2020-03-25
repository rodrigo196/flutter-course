import 'package:flutter/material.dart';

class MainTheme {
  static get theme {
    return ThemeData(
      primarySwatch: Colors.deepPurple,
      accentColor: Colors.limeAccent,
      canvasColor: const Color.fromRGBO(255, 254, 229, 1),
      fontFamily: 'Raleway',
      textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: const Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: TextStyle(
              color: const Color.fromRGBO(20, 51, 51, 1),
            ),
            headline6: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotCondensed',
              fontWeight: FontWeight.bold,
            ),
          ),
    );
  }
}
