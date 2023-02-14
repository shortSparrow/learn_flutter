import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:my_shop/models/https_exception.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  DateTime? _expiryTokeDate;
  String? _userId;

  bool get isAuth {
    return _token != null;
  }

  String? get userId {
    return _userId;
  }

  String? get token {
    if (_expiryTokeDate != null &&
        _expiryTokeDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }

    return null;
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> signIn(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> _authenticate(
    String email,
    String password,
    String urlSegment,
  ) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:${urlSegment}?key=AIzaSyAwkz7u56fEBfbMU3v7_eecgJA88wswJ9E");
    final body = json.encode(
      {
        'email': email,
        'password': password,
        'returnSecureToken': true,
      },
    );

    try {
      final response = await http.post(url, body: body);
      final data = json.decode(response.body);
      if (data['error'] != null) {
        throw HttpException(data['error']['message']);
      }
      _token = data['idToken'];
      _userId = data['localId'];
      _expiryTokeDate =
          DateTime.now().add(Duration(seconds: int.parse(data['expiresIn'])));
      notifyListeners();
    } catch (e) {
      print("oops: ${e}");
      rethrow;
    }
  }

  void logout() {
    _token = null;
    _userId = null;
    _expiryTokeDate = null;
    notifyListeners();
  }
}
