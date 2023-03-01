import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:my_shop/models/https_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  DateTime? _expiryTokeDate;
  String? _userId;
  Timer? _authTimer;

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
      print(data);
      _token = data['idToken'];
      _userId = data['localId'];
      _expiryTokeDate =
          DateTime.now().add(Duration(seconds: int.parse(data['expiresIn'])));
      _autoLogout();
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': token,
        'userId': userId,
        'expiryTokeDate': _expiryTokeDate?.toIso8601String(),
      });
      prefs.setString('userData', userData);
    } catch (e) {
      print("oops: ${e}");
      rethrow;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final userData = json.decode(prefs.getString('userData') as String)
        as Map<String, dynamic>;

    final expiryDate = DateTime.parse(userData['expiryTokeDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = userData['token'];
    _userId = userData['userId'];
    _expiryTokeDate = expiryDate;
    notifyListeners();
    _autoLogout();

    return true;
  }

  void logout() async {
    _token = null;
    _userId = null;
    _expiryTokeDate = null;
    _authTimer?.cancel();
    _authTimer = null;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer?.cancel();
    }

    if (_expiryTokeDate == null) {
      return;
    }
    final timeToExpiry = _expiryTokeDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(const Duration(days: 20), logout);
  }
}
