import 'package:flutter/material.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.teal,
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
      ),
      routes: {
        TabsScreen.ROUTE_NAME: (_) => TabsScreen(),
        CategoryMealsScreen.ROUTE_NAME: (_) => CategoryMealsScreen(),
        MealDetailScreen.ROUTE_NAME: (_) => MealDetailScreen(),
        FiltersScreen.ROUTE_NAME: (_) => FiltersScreen(),
      },
      onUnknownRoute: (_) => MaterialPageRoute(
        // Fallback for unknown routes
        builder: (_) => TabsScreen(),
      ),
    );
  }
}
