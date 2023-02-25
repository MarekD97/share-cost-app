import 'package:flutter/material.dart';
import 'package:share_cost_app/models/person_model.dart';

class CreateGroupView extends StatefulWidget {
  const CreateGroupView({Key? key}) : super(key: key);

  @override
  State<CreateGroupView> createState() => _CreateGroupViewState();
}

class _CreateGroupViewState extends State<CreateGroupView> {
  List<Person> members = List.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create new group')),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8.0),
        children: [
          const TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Name'),
          ),
          TextField(
            decoration: InputDecoration(
                suffix: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.add)),
                border: const OutlineInputBorder(),
                labelText: 'Member'),
          ),
          ElevatedButton(onPressed: () {}, child: const Text('Submit'))
        ],
      ),
    );
  }
}
