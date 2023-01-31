import 'package:flutter/material.dart';
import 'package:my_shop/widgets/order_item.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static String routeName = './orders';

  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your orders'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: orderProvider.orders.length,
        itemBuilder: (context, index) => OrderItem(orderItem: orderProvider.orders[index]),
      ),
    );
  }
}
