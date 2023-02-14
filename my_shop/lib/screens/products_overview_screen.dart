import 'package:flutter/material.dart';
import 'package:my_shop/providers/cart_provider.dart';
import 'package:my_shop/providers/products_provider.dart';
import 'package:my_shop/screens/cart_screen.dart';
import 'package:my_shop/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../widgets/badge.dart';
import '../widgets/products_grid.dart';

enum FilterOptions { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  static String routeName = '/products-overview';

  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var showOnlyFavorites = false;
  var _isLoading = false;

  @override
  void initState() {
    _isLoading = true;
    Provider.of<ProductProvider>(context, listen: false)
        .fetchAndSetProducts()
        .then((_) {
      print("END");
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

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
          ),
          Consumer<CartProvider>(
            builder: (_, cart, child) => Badge(
              value: cart.itemCount.toString(),
              child: child!,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ProductsGrid(
              showOnlyFavorites: showOnlyFavorites,
            ),
    );
  }
}
