import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:my_shop/models/http_exception.dart';
import '../models/secret.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _autTimer;

  bool get isAuth {
    return token != null;
  }

  String get userId {
    return _userId;
  }

  String get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=${Secret.API_KEY}';

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email.trim(),
            'password': password.trim(),
            'returnSecureToken': true,
          },
        ),
      );

      final extractedBody = json.decode(response.body);

      if (extractedBody['error'] != null) {
        throw HttpException(extractedBody['error']['message']);
      }

      _token = extractedBody['idToken'];
      _userId = extractedBody['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(extractedBody['expiresIn'])));

      _autoLogout();
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate.toIso8601String(),
      });
      prefs.setString('USER_DATA', userData);

    } catch (error) {
      throw error;
    }
  }

  Future<void> sigunp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey('USER_DATA')) {
      return false;
    }

    final extractedUserData = json.decode(prefs.getString('USER_DATA')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    print(expiryDate);
    print(DateTime.now());
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();

    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    notifyListeners();
    if (_autTimer != null) {
      _autTimer.cancel();
      _autTimer = null;
    }

    final prefs = await SharedPreferences.getInstance();
    prefs.remove('USER_DATA');
  }

  void _autoLogout() {
    if (_autTimer != null) {
      _autTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _autTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
