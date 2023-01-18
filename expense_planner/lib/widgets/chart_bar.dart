import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentage;

  const ChartBar(
      {super.key,
      required this.label,
      required this.spendingAmount,
      required this.spendingPercentage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 20,
            child: FittedBox(
                child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
        const SizedBox(height: 4),
        SizedBox(
          width: 10,
          height: 60,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    color: const Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10)),
              ),
              FractionallySizedBox(
                heightFactor: spendingPercentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(label)
      ],
    );
  }
}
