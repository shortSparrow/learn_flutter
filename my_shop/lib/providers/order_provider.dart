import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop/models/https_exception.dart';

import '../models/cart_item.dart';
import '../models/order_item.dart';

class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    try {
      final url = Uri.https(
          'flutter-start-http-default-rtdb.firebaseio.com', '/orders.json');

      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw HttpException("Failed to get orders");
      }

      final extractedData = json.decode(response.body) as Map<String, dynamic>?;

      if (extractedData == null) {
        _orders.clear();
        notifyListeners();
        return;
      }

      _orders.clear();
      extractedData.forEach((key, value) {
        _orders.add(
          Order(
            id: key,
            amount: value['amount'],
            products: (value['products'] as List<dynamic>)
                .map(
                  (cartItem) => CartItem(
                    id: cartItem['id'],
                    title: cartItem['title'],
                    quantity: cartItem['quantity'],
                    price: cartItem['price'],
                  ),
                )
                .toList(),
            dateTime: DateTime.parse(value['dateTime']),
          ),
        );
      });

      notifyListeners();
    } catch (exp) {
      return;
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    try {
      final url = Uri.https(
          'flutter-start-http-default-rtdb.firebaseio.com', '/orders.json');

      final timestamp = DateTime.now();

      final response = await http.post(url,
          body: json.encode({
            'amount': total,
            'dateTime': timestamp.toIso8601String(),
            'products': cartProducts
                .map((product) => ({
                      'id': product.id,
                      'title': product.title,
                      'quantity': product.quantity,
                      'price': product.price,
                    }))
                .toList(),
          }));

      if (response.statusCode >= 400) {
        throw HttpException("Failed to add order");
      }

      _orders.add(
        Order(
          id: json.decode(response.body)['name'],
          amount: total,
          products: cartProducts,
          dateTime: DateTime.now(),
        ),
      );

      notifyListeners();
    } catch (exp) {
      rethrow;
    }
  }
}
