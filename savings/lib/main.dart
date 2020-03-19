import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transactions_list.dart';

import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal expenses',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.indigoAccent,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                button: TextStyle(
                  color: Colors.white,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(
            days: 7,
          ),
        ),
      );
    }).toList();
  }

  void _newTransaction(String title, double amount, DateTime date) {
    final newTX = Transaction(
        title: title,
        amount: amount,
        date: date,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTX);
      _userTransactions.sort((a, b) => b.date.compareTo(a.date));
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(_newTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text(
        'Personal expenses',
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );

    final landscapeSwitch = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Show chart',
        ),
        Switch(
          value: _showChart,
          onChanged: (value) {
            setState(() {
              _showChart = value;
            });
          },
        ),
      ],
    );

    final charHeightRatio = isLandScape ? 0.7 : 0.3;

    final chartHeight = (MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            appBar.preferredSize.height) *
        charHeightRatio;

    final listHeight = isLandScape
        ? (MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            appBar.preferredSize.height -
            40)
        : (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                appBar.preferredSize.height) *
            (1 - charHeightRatio);

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandScape) landscapeSwitch,
            if (!isLandScape || _showChart)
              Container(
                height: chartHeight,
                child: Chart(_recentTransactions),
              ),
            if (!isLandScape || !_showChart)
              Container(
                height: listHeight,
                child: TransactionList(_userTransactions, _deleteTransaction),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
