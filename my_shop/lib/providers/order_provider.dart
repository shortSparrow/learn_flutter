import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop/models/https_exception.dart';
import 'package:my_shop/util/constants.dart';

import '../models/cart_item.dart';
import '../models/order_item.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];
  final String? token;
  final String? userId;

  OrderProvider(this._orders, {this.token, this.userId});

  List<Order> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    try {
      final url = Uri.https(
        BASE_URL,
        '/orders/$userId.json',
        {'auth': token},
      );

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
        BASE_URL,
        '/orders/$userId.json',
        {'auth': token},
      );

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
