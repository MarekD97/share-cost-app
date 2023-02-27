import 'package:flutter/material.dart';
import 'package:share_cost_app/components/group_card.dart';
import 'package:share_cost_app/models/expense_model.dart';
import 'package:share_cost_app/models/group_model.dart';
import 'package:share_cost_app/models/person_model.dart';
import 'package:share_cost_app/routes.dart';
import 'package:share_cost_app/services/cloud_firebase_service.dart';

class GroupListView extends StatefulWidget {
  const GroupListView({Key? key}) : super(key: key);

  @override
  State<GroupListView> createState() => _GroupListViewState();
}

class _GroupListViewState extends State<GroupListView> {
  List<Group> groups = List<Group>.empty();

  @override
  Widget build(BuildContext context) {
    void handleOnLongPress() => showModalBottomSheet(
        context: context,
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Rename'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Delete'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ));

    return Scaffold(
      appBar: AppBar(title: const Text('List of expense groups')),
      body: StreamBuilder(
        stream: CloudFirebaseService.getAllGroups(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Group> groups = snapshot.data!.docs.map((doc) {
              return Group.fromJson(doc.data() as Map<String, dynamic>);
            }).toList();
            return ListView.builder(
              itemBuilder: (context, index) => GroupCard(
                group: groups[index],
                onTap: () {
                  Navigator.pushNamed(context, Routes.group,
                      arguments: <String, dynamic>{'id': groups[index].id});
                },
                onLongPress: handleOnLongPress,
              ),
              itemCount: groups.length,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add an expense list',
        onPressed: () {
          Person person = Person(name: 'Marek');
          Expense expense = Expense(
              name: 'Food',
              paidBy: person,
              paidFor: [person, person, person],
              amountSpent: 20.0,
              category: 'Home',
              createdAt: DateTime.now());
          Group group = Group(
              name: 'Family',
              expenses: [expense, expense, expense],
              members: [person, person, person],
              createdAt: DateTime.now());
          CloudFirebaseService.createGroup(group);
          Navigator.pushNamed(context, Routes.createGroup);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
