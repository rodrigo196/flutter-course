import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const ROUTE_NAME = '/meal-detail';
  final Function isFavorite;
  final Function togleFavorite;

  MealDetailScreen(this.isFavorite, this.togleFavorite);

  Widget _buildTitleSection(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _buildContainer(
      {@required Widget child, @required MediaQueryData mediaQuery}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: mediaQuery.size.width,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final meal = DUMMY_MEALS.firstWhere((element) => element.id == mealId);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: mediaQuery.size.height * 0.4,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _buildTitleSection(context, 'Ingredients'),
            _buildContainer(
              mediaQuery: mediaQuery,
              child: ListView.builder(
                itemBuilder: (_, index) => Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(
                      meal.ingredients[index],
                    ),
                  ),
                ),
                itemCount: meal.ingredients.length,
              ),
            ),
            _buildTitleSection(context, 'Steps'),
            _buildContainer(
              mediaQuery: mediaQuery,
              child: ListView.builder(
                itemCount: meal.steps.length,
                itemBuilder: (context, index) => Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${index + 1}'),
                      ),
                      title: Text(meal.steps[index]),
                    ),
                    Divider(
                      height: 2,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          togleFavorite(mealId);
        },
        child: isFavorite(mealId) ? Icon(Icons.star) : Icon(Icons.star_border),
      ),
    );
  }
}
