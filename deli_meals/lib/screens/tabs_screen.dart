import 'package:deli_meals/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../models/tabs_screen_page.dart';
import './categories_screen.dart';
import './favorites_meals_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoritesMeal;

  const TabsScreen({super.key, required this.favoritesMeal});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late final List<TabsScreenPage> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      TabsScreenPage(page: CategoriesScreen(), title: "Categories"),
      TabsScreenPage(
          page: FavoritesMealsScreen(favoritesMeal: widget.favoritesMeal),
          title: "Favorites"),
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_pages[_selectedPageIndex].title)),
      body: _pages[_selectedPageIndex].page,
      drawer: MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
