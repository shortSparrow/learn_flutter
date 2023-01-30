import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

enum FilterOptions { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    void onSelected(FilterOptions value) {
      switch (value) {
        case FilterOptions.favorites:
          setState(() {
            showOnlyFavorites = true;
          });
          break;
        case FilterOptions.all:
          setState(() {
            showOnlyFavorites = false;
          });
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.favorites,
                child: Text('Only favorites'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Show all'),
              ),
            ],
            onSelected: (value) => onSelected(value),
          )
        ],
      ),
      body: ProductsGrid(
        showOnlyFavorites: showOnlyFavorites,
      ),
    );
  }
}
