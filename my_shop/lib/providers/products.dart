import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';
import '../models/http_exception.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoritesItems {
    return items.where((element) => element.isFavorite).toList();
  }

  final String authToken;
  final String userId;

  Products(this.authToken, this.userId, List<Product> previusItems) {
    if (previusItems != null) {
      _items = previusItems;
    }
  }

  Future<void> fetchProducts([bool filterByUser = false]) async {
    final filterString = filterByUser ? '&orderBy="creatorId"&equalTo="$userId"' : '';
    final url =
        'https://flutter-course-4d8b0.firebaseio.com/products.json?auth=$authToken$filterString';

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      final favoritesUrl =
          'https://flutter-course-4d8b0.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoritesResponse = await http.get(favoritesUrl);
      final favoriteData = json.decode(favoritesResponse.body);

      final List<Product> loadedProducts = [];

      extractedData.forEach((prodcutId, productData) {
        loadedProducts.add(Product(
          id: prodcutId,
          title: productData['title'],
          description: productData['description'],
          price: productData['price'],
          isFavorite: favoriteData == null ? false : favoriteData[prodcutId] ?? false,
          imageUrl: productData['imageUrl'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) {
    final url =
        'https://flutter-course-4d8b0.firebaseio.com/products.json?auth=$authToken';

    return http
        .post(
      url,
      body: json.encode({
        'title': product.title,
        'description': product.description,
        'imageUrl': product.imageUrl,
        'price': product.price,
        'creatorId' : userId,
      }),
    )
        .then((response) {
      if (response.statusCode == 200) {
        final newProduct = Product(
            id: json.decode(response.body)['name'],
            description: product.description,
            imageUrl: product.imageUrl,
            price: product.price,
            title: product.title);
        _items.add(newProduct);
        notifyListeners();
      }
    }).catchError((error) {
      print(error);
      throw error;
    });
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> updateProduct(String id, Product product) async {
    final productIndex = _items.indexWhere((element) => element.id == id);
    if (productIndex >= 0) {
      final url =
          'https://flutter-course-4d8b0.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
          }));
      _items[productIndex] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    final url =
        'https://flutter-course-4d8b0.firebaseio.com/products/$id.json?auth=$authToken';
    final existentProductIndex =
        _items.indexWhere((element) => element.id == id);
    final existentProduct = _items[existentProductIndex];
    _items.removeAt(existentProductIndex);
    http.delete(url).then((response) {
      if (response.statusCode >= 400) {
        throw HttpException('Could not delete product.');
      }
    }).catchError((_) => _items.insert(existentProductIndex, existentProduct));
    notifyListeners();
  }
}
