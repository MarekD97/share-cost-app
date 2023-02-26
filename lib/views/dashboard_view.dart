import 'package:flutter/material.dart';
import 'package:share_cost_app/components/balance_card.dart';
import 'package:share_cost_app/components/expense_card.dart';
import 'package:share_cost_app/components/expense_chart.dart';
import 'package:share_cost_app/models/group_model.dart';
import 'package:share_cost_app/routes.dart';
import 'package:share_cost_app/services/cloud_firebase_service.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final balance = [
    {'from': 'Mark', 'to': 'Peter', 'amount': 21.37},
    {'from': 'Tom', 'to': 'Peter', 'amount': 0.91},
    {'from': 'Tom', 'to': 'Peter', 'amount': -100.2},
    {'from': 'John', 'to': 'Mark', 'amount': 30.7},
  ];

  @override
  Widget build(BuildContext context) {
    final groupId = (ModalRoute.of(context)!.settings.arguments
        as Map<String, dynamic>)['id'];
    void navigateToCreateExpenseView() {
      Navigator.pushNamed(context, Routes.createExpense,
          arguments: <String, dynamic>{'id': groupId});
    }

    final Widget expenseTab = StreamBuilder(
        stream: CloudFirebaseService.getGroupById(groupId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Group group = Group.fromJson(
                snapshot.data!.docs[0].data() as Map<String, dynamic>);
            return ListView.builder(
              itemBuilder: (context, index) =>
                  ExpenseCard(expense: group.expenses[index]),
              itemCount: group.expenses.length,
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 60.0),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
    final Widget balanceTab = ListView(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 60.0),
      children: [
        ExpenseChart(balance: balance),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Text(
            'How to split the expenses?',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        Column(
          children: List.generate(balance.length, (index) {
            final item = balance[index];
            return BalanceCard(
              fromWho: item['from'] as String,
              forWhom: item['to'] as String,
              amount: item['amount'] as double,
            );
          }).toList(),
        )
      ],
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          bottom: const TabBar(
            tabs: [Tab(text: 'Expenses'), Tab(text: 'Balance')],
          ),
        ),
        body: TabBarView(
          children: [
            expenseTab,
            balanceTab,
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: navigateToCreateExpenseView,
            tooltip: 'Add an expense',
            child: const Icon(Icons.add)),
      ),
    );
  }
}
