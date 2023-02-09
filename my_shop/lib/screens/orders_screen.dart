import 'package:flutter/material.dart';
import 'package:my_shop/widgets/order_item.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';
import '../widgets/app_drawer.dart';

// * We can use _isLoading with initState in Stateful widget or just use FutureBuilder (with StatefulWidget if want to avoid refetch data)
class OrdersScreen extends StatefulWidget {
  static String routeName = './orders';

  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future _ordersFuture;

  Future _obtainOrdersFuture() {
    return Provider.of<OrderProvider>(context, listen: false)
        .fetchAndSetOrders();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your orders'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        /* 
         We can add just Provider.of<OrderProvider>(context, listen: false).fetchAndSetOrders(),
         but then if widget was rebuild - future will executed again. For avoid it - use _ordersFuture
        **/
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.error != null) {
            return const Center(child: Text('Error'));
          }

          return Consumer<OrderProvider>(
            builder: (context, value, child) => ListView.builder(
              itemCount: value.orders.length,
              itemBuilder: (context, index) =>
                  OrderItem(orderItem: value.orders[index]),
            ),
          );
        },
      ),
    );
  }
}
