import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';
import '../models/http_exception.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoritesItems {
    return items.where((element) => element.isFavorite).toList();
  }

  final String authToken;

  Products(this.authToken, List<Product> previusItems) {
    if (previusItems != null) {
      _items = previusItems;
    }
  }

  Future<void> fetchProducts() async {
    final url =
        'https://flutter-course-4d8b0.firebaseio.com/products.json?auth=$authToken';

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];

      extractedData.forEach((prodcutId, productData) {
        loadedProducts.add(Product(
          id: prodcutId,
          title: productData['title'],
          description: productData['description'],
          price: productData['price'],
          isFavorite: productData['isFavorite'],
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
