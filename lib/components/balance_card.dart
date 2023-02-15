import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({this.fromWho, this.forWhom, this.amount = 0, Key? key})
      : super(key: key);

  final String? fromWho;
  final String? forWhom;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      elevation: 1,
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(fromWho ?? ''),
                const Text(
                  'to',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                Text(forWhom ?? '')
              ],
            ),
            Text('${amount.toStringAsFixed(2)}zł')
          ],
        ),
      ),
    );
  }
}
