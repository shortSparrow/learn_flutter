import 'package:deli_meals/widgets/meal_item.dart';
import 'package:flutter/material.dart';

import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;

  const CategoryMealsScreen({
    super.key,
    required this.availableMeals,
  });

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> displayedMeals;
  var _isInitialDataLoaded = false;

  // void _removeMeal(String mealId) {
  //   setState(() {
  //     displayedMeals.removeWhere((element) => element.id == mealId);
  //   });
  // }

  @override
  void didChangeDependencies() {
    if (!_isInitialDataLoaded) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;

      categoryTitle = routeArgs['title'].toString(); // TODO fix type
      final String categoryId = routeArgs['id'].toString(); // TODO fix type
      displayedMeals = widget.availableMeals
          .where((meal) => meal.categories.contains(categoryId))
          .toList();
      _isInitialDataLoaded = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: ListView.builder(
        itemBuilder: (context, index) => MealItem(
          id: displayedMeals[index].id,
          title: displayedMeals[index].title,
          duration: displayedMeals[index].duration,
          imageUrl: displayedMeals[index].imageUrl,
          complexity: displayedMeals[index].complexity,
          affordability: displayedMeals[index].affordability,
          // removeItem: _removeMeal,
        ),
        itemCount: displayedMeals.length,
      ),
    );
  }
}
