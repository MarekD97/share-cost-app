import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
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
            body: const TabBarView(
              children: [
                Text('Expenses Tab'),
                Text('Balance Tab'),
              ],
            )));
  }
}
