import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _deleteTx;

  TransactionList(this._userTransactions, this._deleteTx);

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
                  SizedBox(
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
                  return Card(
                    elevation: 6,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(
                            child: Text('\$${tx.amount}'),
                          ),
                        ),
                      ),
                      title: Text(
                        tx.title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(DateFormat.yMMMd().format(tx.date)),
                      trailing: MediaQuery.of(context).size.width > 460
                          ? FlatButton.icon(
                              onPressed: () => _deleteTx(tx.id),
                              icon: Icon(Icons.delete),
                              label: Text("Delete"),
                              textColor: Theme.of(context).errorColor,
                            )
                          : IconButton(
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                              onPressed: () => _deleteTx(tx.id),
                            ),
                    ),
                  );
                },
                itemCount: _userTransactions.length,
              );
      },
    );
  }
}
