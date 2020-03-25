import 'package:flutter/material.dart';

import '../screens/tabs_screen.dart';
import '../screens/category_meals_screen.dart';
import '../screens/meal_detail_screen.dart';
import '../screens/filters_screen.dart';

class RoutesTable {
  static final routes = {
        TabsScreen.ROUTE_NAME: (_) => TabsScreen(),
        CategoryMealsScreen.ROUTE_NAME: (_) => CategoryMealsScreen(),
        MealDetailScreen.ROUTE_NAME: (_) => MealDetailScreen(),
        FiltersScreen.ROUTE_NAME: (_) => FiltersScreen(),
      };

  static final unknownRouteHandler = (_) => MaterialPageRoute(
        // Fallback for unknown routes
        builder: (_) => TabsScreen(),
      );
}