import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const ROUTE_NAME = '/category-meals';

  final List<Meal> avaliableMeals;

  CategoryMealsScreen(this.avaliableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String _categoryTitle;
  List<Meal> _displayedMeals;
  Color _categoryColor;
  bool _loadInitializedData = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_loadInitializedData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, Object>;

      _categoryTitle = routeArgs['title'] as String;
      final categoryId = routeArgs['id'] as String;
      _categoryColor = routeArgs['color'] as Color;

      _displayedMeals = widget.avaliableMeals
          .where((element) => element.categories.contains(categoryId))
          .toList();

      _loadInitializedData = true;
    }
  }

  void _removeItem(String mealId) {
    setState(() {
      _displayedMeals.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle),
        backgroundColor: _categoryColor,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          Meal meal = _displayedMeals.elementAt(index);
          return MealItem(
            id: meal.id,
            title: meal.title,
            affordability: meal.affordability,
            complexity: meal.complexity,
            duration: meal.duration,
            imageUrl: meal.imageUrl,
            removeItem: _removeItem,
          );
        },
        itemCount: _displayedMeals.length,
      ),
    );
  }
}
