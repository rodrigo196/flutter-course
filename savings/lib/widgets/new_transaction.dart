import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:savings/widgets/adaptative/adaptative_date_picker.dart';

import './adaptative/adaptative_flat_button.dart';
import './adaptative/adaptative_raised_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTxHandler;

  NewTransaction(this.addTxHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _pickedDate;

  void _submitData() {
    final title = _titleController.text;
    final amount = double.parse(_amountController.text);

    if (title.isNotEmpty && amount > 0 && _pickedDate != null) {
      widget.addTxHandler(_titleController.text,
          double.parse(_amountController.text), _pickedDate);

      Navigator.of(context).pop();
    }
  }

  void _presentDatePicker() {
    final datePicker = AdaptativeDatePicker(context: context);

    datePicker.presentDatePicker(
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
        handler: (value) {
          if (value != null) {
            setState(() {
              _pickedDate = value;
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                keyboardType: TextInputType.text,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _pickedDate == null
                            ? 'No date chosen!'
                            : 'Transacion date: ${DateFormat.yMMMd().format(_pickedDate)}',
                      ),
                    ),
                    AdaptativeFlatButton(
                      text: "Choose date",
                      handler: _presentDatePicker,
                    ),
                  ],
                ),
              ),
              AdaptativeRaisedButton(
                  text: 'Add Transaction', handler: _submitData),
            ],
          ),
        ),
      ),
    );
  }
}
