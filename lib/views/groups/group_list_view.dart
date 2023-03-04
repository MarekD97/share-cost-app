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
  final _nameController = TextEditingController();

  void handleOnLongPress(Group group) => showModalBottomSheet(
      context: context,
      builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Rename'),
                onTap: () => _renameGroup(group),
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete'),
                onTap: () => _deleteGroup(group),
              ),
            ],
          ));

  void _renameGroup(Group group) {
    Navigator.pop(context);
    _nameController.text = group.name;
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: const Text('Rename group'),
              contentPadding: const EdgeInsets.all(8.0),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'New name'),
                    controller: _nameController,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel')),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                        onPressed: () {
                          Group newGroup = Group(
                              id: group.id,
                              name: _nameController.text,
                              createdAt: group.createdAt,
                              members: group.members,
                              expenses: group.expenses);
                          CloudFirebaseService.updateGroup(newGroup);
                          Navigator.pop(context);
                        },
                        child: const Text('Rename'))
                  ],
                )
              ],
            ));
  }

  void _deleteGroup(Group group) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No')),
          TextButton(
              onPressed: () {
                CloudFirebaseService.deleteGroupById(group.id);
                Navigator.pop(context);
              },
              child: const Text('Yes')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                onLongPress: () => handleOnLongPress(groups[index]),
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
