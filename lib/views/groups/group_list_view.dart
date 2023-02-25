import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
              itemBuilder: (context, index) {
                Group group = groups[index];
                DateFormat format = DateFormat('yyyy-MM-dd, hh:mm');
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  elevation: 1,
                  child: ListTile(
                    title: Text(group.name),
                    subtitle:
                        Text('Created at: ${format.format(group.createdAt)}'),
                    onLongPress: handleOnLongPress,
                    onTap: () {
                      Navigator.pushNamed(context, Routes.dashboard,
                          arguments: <String, dynamic>{'id': group.id});
                    },
                  ),
                );
              },
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
