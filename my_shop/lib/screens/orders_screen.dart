import 'package:flutter/material.dart';
import 'package:my_shop/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const ROUTE_NAME = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false).fetchOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error on fetch data!'),
                );
              } else {
                return Consumer<Orders>(
                  builder: (context, orders, child) => ListView.builder(
                    itemBuilder: (ctx, index) => OrderItem(
                      orders.orders[index],
                    ),
                    itemCount: orders.orders.length,
                  ),
                );
              }
            }
          }),
    );
  }
}
