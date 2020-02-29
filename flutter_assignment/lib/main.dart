import 'package:flutter/material.dart';
import './text.dart';
import './text_control.dart';

// 1) Create a new Flutter App (in this project) and output an AppBar and some text
// below it
// 2) Add a button which changes the text (to any other text of your choice)
// 3) Split the app into three widgets: App, TextControl & Text
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  var _messageIndex = 0;

  final _messages = const [
    "Message 1",
    "Message 2",
    "Message 3",
    "Message 4",
    "Message 5",
  ];

  void changeMessage() {
    setState(() {
      if (_messageIndex < _messages.length - 1){
        _messageIndex += 1;
      } else {
        _messageIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter assignment 1"),
        ),
        body: Column(
          children: <Widget>[
            MyText(_messages[_messageIndex]),
            TextControl(changeMessage),
          ],
        ),
      ),
    );
  }
}
