import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop/models/https_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _setIsFavorite(bool value) {
    isFavorite = value;
    notifyListeners();
  }

  Future<void> toggleIsFavorite() async {
    final oldIsFavorite = isFavorite;
    _setIsFavorite(!isFavorite);

    try {
      final url = Uri.https('flutter-start-http-default-rtdb.firebaseio.com',
          '/products/${this.id}.json');
      final response = await http.patch(url,
          body: json.encode({
            'isFavorite': isFavorite,
          }));
      if (response.statusCode >= 400) {
        throw HttpException("Failed to change isFavorite");
      }
    } catch (exp) {
      _setIsFavorite(oldIsFavorite);
      rethrow;
    }
  }

  Product copy(
      {String? id,
      String? title,
      String? description,
      double? price,
      String? imageUrl,
      bool? isFavorite}) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
