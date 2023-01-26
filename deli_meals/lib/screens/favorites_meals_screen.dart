import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesMealsScreen extends StatelessWidget {
  final List<Meal> favoritesMeal;

  const FavoritesMealsScreen({super.key, required this.favoritesMeal});

  @override
  Widget build(BuildContext context) {
    if(favoritesMeal.isEmpty) {
 return const Center(
      child: Text('You don\'t have any favorites meals yet'),
    );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) => MealItem(
          id: favoritesMeal[index].id,
          title: favoritesMeal[index].title,
          duration: favoritesMeal[index].duration,
          imageUrl: favoritesMeal[index].imageUrl,
          complexity: favoritesMeal[index].complexity,
          affordability: favoritesMeal[index].affordability,
        ),
        itemCount: favoritesMeal.length,
      );
    }
   
  }
}
