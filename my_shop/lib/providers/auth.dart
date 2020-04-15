import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop/models/http_exception.dart';
import '../models/secret.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return token != null;
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

      notifyListeners();
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
}
