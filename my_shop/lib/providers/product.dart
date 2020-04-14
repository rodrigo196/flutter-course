import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop/models/http_exception.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    @required this.title,
    this.isFavorite = false,
  });

  Future<void> toogleFavorite() async {
    final oldState = isFavorite;
    
    isFavorite = !isFavorite;
    notifyListeners();

    final url = 'https://flutter-course-4d8b0.firebaseio.com/products/$id.json';
    final response = await http.patch(url, body: jsonEncode({
      'isFavorite' : isFavorite
    }));
    
    if (response.statusCode >= 400) {
      isFavorite = oldState;
      notifyListeners();
      throw HttpException('An error occured when updating favorite state');
    }
  }
}