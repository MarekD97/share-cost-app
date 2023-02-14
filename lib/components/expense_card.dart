import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({this.title, this.price, this.date, Key? key})
      : super(key: key);

  final String? title;
  final double? price;
  final DateTime? date;

  final String currency = 'zł';

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      elevation: 1,
      child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title ?? ''),
              Text(price != null ? '${price!.toStringAsFixed(2)} $currency' : '')
            ],
          ),
          subtitle: Text(date != null ? date!.toIso8601String() : '')),
    );
  }
}
