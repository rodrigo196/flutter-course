import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop/models/http_exception.dart';

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  final String authToken;

  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Orders(this.authToken, List<OrderItem> previusOrders) {
    if (previusOrders != null) {
      _orders = previusOrders;
    }
  }

  Future<void> fetchOrders() async {
    final url =
        'https://flutter-course-4d8b0.firebaseio.com/orders.json?auth=$authToken';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<OrderItem> orders = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData != null) {
        extractedData.forEach((key, value) {
          final List<CartItem> products = [];

          value['products'].forEach((element) {
            products.add(CartItem(
              id: element['id'],
              price: element['price'],
              quantity: element['quantity'],
              title: element['title'],
            ));
          });

          orders.add(OrderItem(
            id: key,
            amount: value['amount'],
            dateTime: DateTime.parse(value['dateTime']),
            products: products,
          ));
        });
      }
      _orders = orders;
      notifyListeners();
    } else {
      throw HttpException('Error occurred when fetch order data!');
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url =
        'https://flutter-course-4d8b0.firebaseio.com/orders.json?auth=$authToken';

    final body = json.encode({
      'amount': total,
      'dateTime': DateTime.now().toIso8601String(),
      'products': cartProducts
          .map((e) => {
                'id': e.id,
                'price': e.price,
                'quantity': e.quantity,
                'title': e.title,
              })
          .toList(),
    });

    final response = await http.post(url, body: body);

    if (response.statusCode == 200 && response.body != null) {
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          products: cartProducts,
          dateTime: DateTime.now(),
        ),
      );
      notifyListeners();
    } else {
      throw HttpException('Error on add order!');
    }
  }
}
