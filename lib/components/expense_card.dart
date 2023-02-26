import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_cost_app/models/expense_model.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard(
      {required this.expense, this.onTap, this.onLongPress, Key? key})
      : super(key: key);

  final Expense expense;
  final Function()? onTap;
  final Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      elevation: 1,
      child: ListTile(
          onTap: onTap,
          onLongPress: onLongPress,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(expense.name),
              Text('${expense.amountSpent.toStringAsFixed(2)} zł')
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Paid by ${expense.paidBy.name}'),
              Text(DateFormat('yyyy-MM-dd').format(expense.createdAt)),
            ],
          )),
    );
  }
}
