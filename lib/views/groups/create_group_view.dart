import 'package:flutter/material.dart';
import 'package:share_cost_app/models/group_model.dart';
import 'package:share_cost_app/models/person_model.dart';
import 'package:share_cost_app/services/cloud_firebase_service.dart';

class CreateGroupView extends StatefulWidget {
  const CreateGroupView({Key? key}) : super(key: key);

  @override
  State<CreateGroupView> createState() => _CreateGroupViewState();
}

class _CreateGroupViewState extends State<CreateGroupView> {
  List<Person> members = List.empty(growable: true);
  final _nameController = TextEditingController();
  final _memberController = TextEditingController();

  void _addMemberToList() => setState(() {
        members.add(Person(name: _memberController.text));
      });

  void _removeMemberFromList(Person member) => setState(() {
        members.remove(member);
      });

  void _submitForm() {
    Group group = Group(
        name: _nameController.text,
        expenses: List.empty(),
        members: members,
        createdAt: DateTime.now());
    CloudFirebaseService.createGroup(group);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create new group')),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8.0),
        children: [
          TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'Name'),
            controller: _nameController,
          ),
          Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Member list:',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    ...members
                        .map((member) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(member.name),
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () =>
                                        _removeMemberFromList(member),
                                  )
                                ]))
                        .toList()
                  ])),
          Row(
            children: [
              Flexible(
                child: TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Member name'),
                  controller: _memberController,
                ),
              ),
              const SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: _addMemberToList,
                child: const Text('Add member'),
              )
            ],
          ),
          ElevatedButton(onPressed: _submitForm, child: const Text('Submit'))
        ],
      ),
    );
  }
}
