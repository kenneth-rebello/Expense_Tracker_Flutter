import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function deleteTransaction;

  TransactionList(this._transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    final mediaConst = MediaQuery.of(context);
    return _transactions.length > 0
        ? Container(
            margin: EdgeInsets.all(10),
            height: 400,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.tight,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2),
                          ),
                          child: FittedBox(
                            child: Text(
                              '\$ ${_transactions[index].amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _transactions[index].title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              DateFormat('dd MMM yyyy')
                                  .format(_transactions[index].date),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: mediaConst.size.width > 400
                            ? FlatButton.icon(
                                onPressed: () {
                                  deleteTransaction(_transactions[index].id);
                                },
                                icon: Icon(Icons.delete_forever),
                                label: Text('Delete'),
                                color: Theme.of(context).errorColor,
                              )
                            : IconButton(
                                icon: Icon(Icons.delete_forever),
                                onPressed: () {
                                  deleteTransaction(_transactions[index].id);
                                },
                                color: Theme.of(context).errorColor,
                              ),
                      )
                    ],
                  ),
                );
              },
              itemCount: _transactions.length,
            ),
          )
        : LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  'You have no transactions yet',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight * 0.65,
                  child: Image.asset(
                    'assets/images/savings.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          });
  }
}
