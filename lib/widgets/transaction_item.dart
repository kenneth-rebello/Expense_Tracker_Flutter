import 'dart:math';

import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  final Transaction _transaction;
  final Function deleteTransaction;

  TransactionItem(key, this._transaction, this.deleteTransaction);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;
  @override
  void initState() {
    super.initState();
    const colors = [
      Colors.blue,
      Colors.purple,
      Colors.deepPurple,
      Colors.amber,
      Colors.pink
    ];
    _bgColor = colors[Random().nextInt(5)];
  }

  @override
  Widget build(BuildContext context) {
    final mediaConst = MediaQuery.of(context);
    return Card(
      child: Row(
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: mediaConst.orientation == Orientation.landscape ? 1 : 2,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: _bgColor, width: 2),
              ),
              child: FittedBox(
                child: Text(
                  '\$ ${widget._transaction.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _bgColor,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget._transaction.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  DateFormat('dd MMM yyyy').format(widget._transaction.date),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: mediaConst.size.width > 400
                ? RaisedButton.icon(
                    onPressed: () {
                      widget.deleteTransaction(widget._transaction.id);
                    },
                    icon: Icon(
                      Icons.delete_forever,
                      color: Theme.of(context).errorColor,
                    ),
                    label: Text(
                      'Delete',
                      style: TextStyle(
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                    color: Colors.white,
                  )
                : IconButton(
                    icon: Icon(
                      Icons.delete_forever,
                    ),
                    onPressed: () {
                      widget.deleteTransaction(widget._transaction.id);
                    },
                    color: Theme.of(context).errorColor,
                  ),
          )
        ],
      ),
    );
  }
}
