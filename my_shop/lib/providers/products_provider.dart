import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:my_shop/providers/product.dart';

import '../models/https_exception.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _items = [];
  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return [..._items].where((element) => element.isFavorite).toList();
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.https(
        'flutter-start-http-default-rtdb.firebaseio.com', '/products.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> tempProductList = [];
      extractedData.forEach((productId, productData) {
        tempProductList.add(Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
        ));
      });

      _items = tempProductList;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.https(
        'flutter-start-http-default-rtdb.firebaseio.com', '/products.json');

    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
          }));

      final newProduct = product.copy(id: json.decode(response.body)['name']);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> updateProduct(Product newProduct) async {
    final prodIndex =
        _items.indexWhere((element) => element.id == newProduct.id);

    if (prodIndex >= 0) {
      try {
        final url = Uri.https('flutter-start-http-default-rtdb.firebaseio.com',
            '/products/${newProduct.id}.json');

        await http.patch(url,
            body: json.encode({
              'title': newProduct.title,
              'description': newProduct.description,
              'imageUrl': newProduct.imageUrl,
              'price': newProduct.price,
            }));
        _items[prodIndex] = newProduct;
        notifyListeners();
      } catch (err) {
        print("updateProduct error: ${err}");
        rethrow;
      }
    } else {
      print("Product does not exist");
    }
  }

  Product findProductById(String productId) {
    return _items.firstWhere((element) => element.id == productId);
  }

  Future<void> deleteProduct(String productId) async {
    final url = Uri.https('flutter-start-http-default-rtdb.firebaseio.com',
        '/products/$productId.json');
    final existingProductIndex =
        _items.indexWhere((element) => element.id == productId);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeWhere((element) => element.id == productId);
    notifyListeners();
    try {
      final response = await http.delete(url);
      if (response.statusCode >= 400) {
        throw HttpException("failed to delete product");
      }
      existingProduct = null;
    } catch (_) {
      _items.insert(existingProductIndex, existingProduct!);
      notifyListeners();
      rethrow;
    }
  }
}
