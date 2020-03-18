import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../widgets/new_transaction.dart';
import '../widgets/transactions_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [];

  void _newTransaction(String title, double amount) {
    final newTX = Transaction(
        title: title,
        amount: amount,
        date: DateTime.now(),
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTX);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        NewTransaction(_newTransaction),
        TransactionList(_userTransactions, null),
      ],
    );
  }
}
