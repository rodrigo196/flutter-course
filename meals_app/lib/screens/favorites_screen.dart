import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoritesMeals;

  FavoritesScreen(this.favoritesMeals);
  @override
  Widget build(BuildContext context) {
    if (favoritesMeals.isEmpty) {
      return Center(
        child: Text('No favorites yeat - Start add some!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          Meal meal = favoritesMeals.elementAt(index);
          return MealItem(
            id: meal.id,
            title: meal.title,
            affordability: meal.affordability,
            complexity: meal.complexity,
            duration: meal.duration,
            imageUrl: meal.imageUrl,
            removeItem: null,
          );
        },
        itemCount: favoritesMeals.length,
      );
    }
  }
}
