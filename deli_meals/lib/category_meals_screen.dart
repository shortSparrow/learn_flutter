import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';

  const CategoryMealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    final String categoryTitle = routeArgs['title'].toString(); // TODO fix type
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: const Center(
        child: Text("The recipe for the category"),
      ),
    );
  }
}
