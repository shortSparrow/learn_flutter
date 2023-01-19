import 'package:expense_planner/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
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
          ? LayoutBuilder(builder: ((ctx, builder) {
              return Column(
                children: [
                  Text(
                    "no transactions added yed",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: builder.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/no_transaction.png',
                      fit: BoxFit.scaleDown,
                    ),
                  )
                ],
              );
            }))
          : ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: transactions.length,
              itemBuilder: (context, index) => TransactionItem(
                  key: ValueKey(transactions[index].id),
                  transaction: transactions[index],
                  deleteTransaction: deleteTransaction),
            ),
    );
  }
}
