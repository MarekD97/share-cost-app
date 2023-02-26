import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_cost_app/models/group_model.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({required this.group, this.onTap, this.onLongPress, Key? key})
      : super(key: key);

  final Group group;
  final Function()? onTap;
  final Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat('yyyy-MM-dd');
    num sum = group.expenses.fold(
        0.0, (previousValue, element) => previousValue + element.amountSpent);
    String members = group.members.map((element) => element.name).join(", ");
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      elevation: 1,
      child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(group.name), Text('${sum.toStringAsFixed(2)} zł')],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(members),
              Text(format.format(group.createdAt)),
            ],
          ),
          onLongPress: onLongPress,
          onTap: onTap),
    );
  }
}
