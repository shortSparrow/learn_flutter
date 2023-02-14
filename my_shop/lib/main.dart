import 'package:flutter/material.dart';
import 'package:my_shop/providers/auth_provider.dart';
import 'package:my_shop/providers/order_provider.dart';
import 'package:my_shop/screens/auth_screen.dart';
import 'package:my_shop/screens/cart_screen.dart';
import 'package:my_shop/screens/edit_product_screen.dart';
import 'package:my_shop/screens/orders_screen.dart';
import 'package:my_shop/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';

import 'providers/cart_provider.dart';
import 'providers/products_provider.dart';
import 'screens/product_details_screen.dart';
import 'screens/user_products_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // declare here if provider is needed for more than 1 screen
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProxyProvider<AuthProvider, ProductProvider>(
          create: (context) => ProductProvider(token: null, userId: null, []),
          update: (context, auth, previous) => ProductProvider(
            token: auth.token,
            userId: auth.userId,
            previous == null ? [] : previous.items,
          ),
        ),
        ChangeNotifierProxyProvider<AuthProvider, OrderProvider>(
          create: (context) => OrderProvider(token: null, userId: null, []),
          update: (context, auth, previous) => OrderProvider(
            token: auth.token,
            userId: auth.userId,
            previous == null ? [] : previous.orders,
          ),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return MaterialApp(
            title: 'My Shop',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                  .copyWith(secondary: Colors.deepOrange),
              fontFamily: 'Lato',
            ),
            home: auth.isAuth
                ? const ProductsOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (context, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : const AuthScreen(),
                  ),
            routes: {
              ProductDetailsScreen.routeName: (_) =>
                  const ProductDetailsScreen(),
              CartScreen.routeName: (_) => const CartScreen(),
              OrdersScreen.routeName: (_) => const OrdersScreen(),
              UserProductsScreen.routeName: (_) => const UserProductsScreen(),
              EditProductScreen.routeName: (_) => const EditProductScreen(),
            },
          );
        },
      ),
    );
  }
}
