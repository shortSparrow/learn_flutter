import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String id) deleteTransaction;

  const TransactionList(
      {super.key, required this.transactions, required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: transactions.isEmpty
          ? Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "no transactions added yed",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: 10),
                Container(
                  // color: Colors.blue,
                  height: 200,
                  child: Image.asset(
                    'assets/images/no_transaction.png',
                    fit: BoxFit.scaleDown,
                  ),
                )
              ],
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: transactions.length,
              itemBuilder: (context, index) => Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    elevation: 2,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text('\$${transactions[index].amount}'),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () =>
                            deleteTransaction(transactions[index].id),
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                  )),
    );
  }
}
