import 'package:flutter/material.dart';

import '../screens/add_place_screen.dart';

class PlaceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(AddPlaceScreen.ROUTE_NAME),
          ),
        ],
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ), //ListView.builder(itemBuilder: null),
    );
  }
}
