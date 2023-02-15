import 'package:flutter/material.dart';
import 'package:share_cost_app/components/expense_card.dart';
import 'package:share_cost_app/routes.dart';

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
  final Widget _balanceTab = Column(
    children: [
      SizedBox(
        width: double.infinity,
        height: 400.0,
        child: ListView.builder(
          itemBuilder: (context, index) => Row(
            children: [
              Text('Title $index'),
              Container(
                height: 20.0,
                width: 200.0,
                margin: EdgeInsets.all(4.000),
              )
            ],
          ),
          itemCount: 3,
        ),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    void navigateToCreateExpenseView() {
      Navigator.pushNamed(context, Routes.createExpense);
    }

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
            onPressed: navigateToCreateExpenseView,
            tooltip: 'Add an expense',
            child: const Icon(Icons.add)),
      ),
    );
  }
}
