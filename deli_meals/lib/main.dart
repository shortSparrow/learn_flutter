import 'package:deli_meals/dummy_data.dart';
import 'package:flutter/material.dart';

import './screens/category_meals_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/unknown_screen.dart';
import './screens/tabs_screen.dart';
import './screens/filters_screen.dart';
import 'models/filters.dart';
import 'models/meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Filters _filters = Filters();
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void setFilters(Filters filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (!meal.isGlutenFree && _filters.gluten) {
          return false;
        }

        if (!meal.isLactoseFree && _filters.lactose) {
          return false;
        }

        if (!meal.isVegan && _filters.vegan) {
          return false;
        }

        if (!meal.isVegetarian && _filters.vegetarian) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((element) => element.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      final newFavoriteMeal =
          DUMMY_MEALS.firstWhere((element) => element.id == mealId);

      setState(() {
        _favoriteMeals.add(newFavoriteMeal);
      });
    }
  }

  bool _isMealFavorite(String mealId) {
    return _favoriteMeals.any((element) => element.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        canvasColor: const Color.fromRGBO(255, 244, 229, 1),
        fontFamily: 'Releway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              headline1: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
            ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(secondary: Colors.amber),
      ),
      routes: {
        '/': (context) => TabsScreen(favoritesMeal: _favoriteMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(availableMeals: _availableMeals),
        MealDetailsScreen.routeName: (context) => MealDetailsScreen(
              toggleFavorite: _toggleFavorite,
              isMealFavorite: _isMealFavorite,
            ),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(filters: _filters, saveFilters: setFilters),
      },
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (context) => UnknownScreen()),
    );
  }
}
