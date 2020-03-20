import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _deleteTx;

  const TransactionList(this._userTransactions, this._deleteTx);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return _userTransactions.isEmpty
            ? Column(
                children: <Widget>[
                  Container(
                    height: 20,
                    child: Text(
                      'No transactions added yet!',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: constraints.maxHeight - 30,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  final tx = _userTransactions[index];
                  return TransactionItem(tx: tx, deleteTx: _deleteTx);
                },
                itemCount: _userTransactions.length,
              );
      },
    );
  }
}
