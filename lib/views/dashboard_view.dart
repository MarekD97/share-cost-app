import 'package:flutter/material.dart';
import 'package:share_cost_app/components/expense_card.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  final Widget _expenseTab = ListView.builder(
    itemBuilder: (context, index) => ExpenseCard(
        title: 'Item ${index + 1}',
        price: (index * 10) % 13,
        date: DateTime.now()),
    itemCount: 20,
    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 60.0),
  );
  final Widget _balanceTab = const Text('Balance Tab');

  @override
  Widget build(BuildContext context) {
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
              _expenseTab,
              _balanceTab,
            ],
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {}, child: const Icon(Icons.add)),
          ),
        );
  }
}
