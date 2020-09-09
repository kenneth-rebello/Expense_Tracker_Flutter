import 'package:expense_tracker/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function deleteTransaction;

  TransactionList(this._transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return _transactions.length > 0
        ? Container(
            margin: EdgeInsets.all(10),
            height: 400,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return TransactionItem(
                  ValueKey(
                    _transactions[index].id,
                  ),
                  _transactions[index],
                  deleteTransaction,
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
