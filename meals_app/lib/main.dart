import 'package:flutter/material.dart';

import './styles/main_theme.dart';
import './navigation/routes_table.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: MainTheme.theme,
      routes: RoutesTable.routes,
      onUnknownRoute: RoutesTable.unknownRouteHandler,
    );
  }
}
