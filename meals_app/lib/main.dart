import 'package:flutter/material.dart';

import './screens/meal_detail_screen.dart';
import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.cyan,
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
        CategoriesScreen.ROUTE_NAME: (_) => CategoriesScreen(),
        CategoryMealsScreen.ROUTE_NAME: (_) => CategoryMealsScreen(),
        MealDetailScreen.ROUTE_NAME: (_) => MealDetailScreen(),
      },
      onUnknownRoute: (_) => MaterialPageRoute(
        // Fallback for unknown routes 
        builder: (_) => CategoryMealsScreen(),
      ),
    );
  }
}
