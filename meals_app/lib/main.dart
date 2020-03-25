import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';

import './styles/main_theme.dart';
import './screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/filters_screen.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoritesMeals = [];

  void _setFilters(Map<String, bool> newFilters) {
    setState(() {
      _filters = newFilters;

      _availableMeals =
          DUMMY_MEALS.where((element) => _checkFilters(element)).toList();
    });
  }

  bool _checkFilters(Meal meal) {
    if (_filters['gluten'] && !meal.isGlutenFree) {
      return false;
    }
    if (_filters['lactose'] && !meal.isLactoseFree) {
      return false;
    }
    if (_filters['vegan'] && !meal.isVegan) {
      return false;
    }
    if (_filters['vegetarian'] && !meal.isVegetarian) {
      return false;
    }
    return true;
  }

  void _toogleFavorites(String mealId) {
    final index = _favoritesMeals.indexWhere((meal) => meal.id == mealId);
    if (index >= 0){
      setState(() {
        _favoritesMeals.removeAt(index);
      });
    } else {
      setState(() {
        _favoritesMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isFavorite(mealId) {
    return _favoritesMeals.indexWhere((meal) => meal.id == mealId) >= 0;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: MainTheme.theme,
      routes: {
        TabsScreen.ROUTE_NAME: (_) => TabsScreen(_favoritesMeals),
        CategoryMealsScreen.ROUTE_NAME: (_) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.ROUTE_NAME: (_) => MealDetailScreen(_isFavorite, _toogleFavorites),
        FiltersScreen.ROUTE_NAME: (_) => FiltersScreen(_filters, _setFilters),
      },
      onUnknownRoute: (_) => MaterialPageRoute(
        // Fallback for unknown routes
        builder: (_) => TabsScreen(_favoritesMeals),
      ),
    );
  }
}
