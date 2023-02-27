import 'package:flutter/material.dart';

class BalanceChart extends StatelessWidget {
  const BalanceChart({required this.balance, Key? key}) : super(key: key);

  final List<Map<String, dynamic>> balance;

  @override
  Widget build(BuildContext context) {
    double maxWidth = balance
        .map(((element) => element['amountSpent'] as double))
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
                    Text(item['member'] as String),
                  ],
                ),
                Stack(children: [
                  Container(
                      margin: const EdgeInsets.all(2.0),
                      padding: item['amountSpent'].abs() / maxWidth < 0.5
                          ? const EdgeInsets.all(8.0)
                          : const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 8.0),
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width *
                          (item['amountSpent'] as double).abs() /
                          maxWidth,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                          color: (item['amountSpent'] as double).isNegative
                              ? Colors.red
                              : Colors.green),
                      child: item['amountSpent'].abs() / maxWidth > 0.5
                          ? Text(
                              '${(item['amountSpent'] as double).toStringAsFixed(2)}zł',
                              style: const TextStyle(color: Colors.white),
                            )
                          : null),
                  if (item['amountSpent'].abs() / maxWidth < 0.5)
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          item['amountSpent'] / maxWidth < 0.5
                              ? MediaQuery.of(context).size.width *
                                      (item['amountSpent'] as double).abs() /
                                      maxWidth +
                                  8.0
                              : 0.0,
                          2.0,
                          item['amountSpent'] / maxWidth < 0.5
                              ? 0.0
                              : MediaQuery.of(context).size.width *
                                      (1.0 -
                                          (item['amountSpent'] as double)
                                                  .abs() /
                                              maxWidth) +
                                  8.0,
                          2.0),
                      alignment: item['amountSpent'] / maxWidth < 0.5
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Text(
                          '${(item['amountSpent'] as double).toStringAsFixed(2)}zł'),
                    )
                ]),
              ],
            );
          }),
        ),
      ),
    );
  }
}
