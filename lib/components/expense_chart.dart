import 'package:flutter/material.dart';

class ExpenseChart extends StatelessWidget {
  const ExpenseChart({required this.balance, Key? key}) : super(key: key);

  final List<Map<String, dynamic>> balance;

  @override
  Widget build(BuildContext context) {
    double maxWidth = balance
        .map((item) => (item['amount'] as double).abs())
        .reduce((value, element) => value > element ? value : element);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(balance.length, (index) {
            final item = balance[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item['from'] as String),
                    Text('${(item['amount'] as double).toStringAsFixed(2)}zł'),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(2.0),
                  padding: const EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width *
                      (item['amount'] as double).abs() /
                      maxWidth,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                      color: (item['amount'] as double).isNegative
                          ? Colors.red
                          : Colors.green),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
