import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatefulWidget {
  static const ROUTE_NAME = './cart-screen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var _isAddingOrder = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _placeOrder() async {
    final cart = Provider.of<Cart>(
      context,
      listen: false,
    );

    if (cart.items.length == 0) {
      return;
    }

    setState(() {
      _isAddingOrder = true;
    });

    try {
      await Provider.of<Orders>(
        context,
        listen: false,
      ).addOrder(
        cart.items.values.toList(),
        cart.totalAmount,
      );
      cart.clearCart();
    } catch (error) {
      print(error.toString());
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            'Error on place order!',
            textAlign: TextAlign.center,
          ),
        ),
      );
    } finally {
      setState(() {
        _isAddingOrder = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  _isAddingOrder
                      ? CircularProgressIndicator()
                      : FlatButton(
                          child: const Text('Order now'),
                          onPressed: _placeOrder,
                          textColor: Theme.of(context).primaryColor,
                        ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (context, index) {
                final item = cart.items.values.elementAt(index);
                return CartItem(
                  id: item.id,
                  price: item.price,
                  quantity: item.quantity,
                  title: item.title,
                  productId: cart.items.keys.elementAt(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
