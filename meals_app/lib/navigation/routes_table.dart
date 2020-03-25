import 'package:flutter/material.dart';

import '../screens/tabs_screen.dart';

class RoutesTable {     
  static final unknownRouteHandler = (_) => MaterialPageRoute(
        // Fallback for unknown routes
        builder: (_) => TabsScreen(),
      );
}