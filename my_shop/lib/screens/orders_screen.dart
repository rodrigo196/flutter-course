import 'package:flutter/material.dart';
import 'package:my_shop/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const ROUTE_NAME = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isInit = true;
  var _isLoading = false;

  Orders orders;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isLoading = true;
      orders = Provider.of<Orders>(context);
      orders.fetchOrders().catchError((_) {
        setState(() {
          _isLoading = false;
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('Error on fetch orders!'),
            ),
          );
        });
      }).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your orders'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) => OrderItem(
                orders.orders[index],
              ),
              itemCount: orders.orders.length,
            ),
    );
  }
}
