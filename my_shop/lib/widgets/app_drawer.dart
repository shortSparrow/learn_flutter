import 'package:flutter/material.dart';
import 'package:my_shop/helpers/custom_route.dart';
import 'package:my_shop/providers/auth_provider.dart';
import 'package:my_shop/screens/orders_screen.dart';
import 'package:my_shop/screens/user_products_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("Hello friend!"),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            title: const Text('Shop'),
            leading: const Icon(Icons.shop),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          const Divider(),
          ListTile(
            title: const Text('Orders'),
            leading: const Icon(Icons.payment),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(OrdersScreen.routeName),

            // // custom animation navigation for one specific screen
            // onTap: () => Navigator.of(context).pushReplacement(
            //   CustomRoute(
            //     builder: (context) => const OrdersScreen(),
            //   ),
            // ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Manage products'),
            leading: const Icon(Icons.edit),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(UserProductsScreen.routeName),
          ),
          const Divider(),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.exit_to_app),
            onTap: Provider.of<AuthProvider>(context).logout,
          ),
        ],
      ),
    );
  }
}
