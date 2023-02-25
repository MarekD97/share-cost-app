import 'package:flutter/material.dart';
import 'package:share_cost_app/routes.dart';

class ExpenseListView extends StatefulWidget {
  const ExpenseListView({Key? key}) : super(key: key);

  @override
  State<ExpenseListView> createState() => _ExpenseListViewState();
}

class _ExpenseListViewState extends State<ExpenseListView> {

  List<String> expenseList = [
    'First list',
    'Second list',
    'Third list'
  ];

  @override
  Widget build(BuildContext context) {

    void navigateToDashboardView() {
      Navigator.pushNamed(context, Routes.dashboard);
    }
    
    void navigateToCreateExpenseListView() {
      Navigator.pushNamed(context, Routes.createGroup);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses')
      ),
      body: ListView.builder(itemBuilder: (context, index) => ListTile(
        title: Text(expenseList[index]),
        onTap: navigateToDashboardView,
      ), itemCount: expenseList.length,),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add an expense list',
        onPressed: navigateToCreateExpenseListView,
        child: const Icon(Icons.add),
      ),
    );
  }
}
