import 'chart_bar.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GroupedTransactionValue {
  final String day;
  final double amount;

  GroupedTransactionValue({required this.day, required this.amount});
}

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({super.key, required this.recentTransactions});

  List<GroupedTransactionValue> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var element in recentTransactions) {
        if (element.date.day == weekDay.day &&
            element.date.month == weekDay.month &&
            element.date.year == weekDay.year) {
          totalSum += element.amount;
        }
      }

      return GroupedTransactionValue(
          day: DateFormat.E().format(weekDay).substring(0, 1),
          amount: totalSum);
    }).reversed.toList();
  }

  get totalSpending {
    return groupedTransactionValues.fold(
        0.0, (previousValue, element) => previousValue + element.amount);
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        // if I set only padding I can use Padding widget instead of Container
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues
              .map(
                (data) => Flexible(
                  fit: FlexFit
                      .tight, // all items width equals of width each other
                  child: ChartBar(
                    label: data.day,
                    spendingAmount: data.amount,
                    spendingPercentage:
                        totalSpending == 0 ? 0.0 : data.amount / totalSpending,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
