import 'package:flutter/material.dart';
import 'package:my_shop/providers/auth.dart';
import 'package:provider/provider.dart';

import '../screens/user_products_screen.dart';
import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  Widget _buildMenuItem(BuildContext context, IconData iconData, String text,
      String destinyRoute) {
    return Column(
      children: <Widget>[
        Divider(),
        ListTile(
          leading: Icon(iconData),
          title: Text(text),
          onTap: () => Navigator.of(
            context,
          ).pushReplacementNamed(
            destinyRoute,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Hello friend!'),
            automaticallyImplyLeading: false,
          ),
          _buildMenuItem(
            context,
            Icons.shop,
            'Shop',
            '/',
          ),
          _buildMenuItem(
            context,
            Icons.payment,
            'Orders',
            OrdersScreen.ROUTE_NAME,
          ),
          _buildMenuItem(
            context,
            Icons.phone_android,
            'My products',
            UserProductsScreen.ROUTE_NAME,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(
                context,
                listen: false,
              ).logout();
            },
          ),
        ],
      ),
    );
  }
}
