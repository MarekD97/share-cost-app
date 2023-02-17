import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:share_cost_app/routes.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //   Navigator.pushReplacementNamed(context, Routes.login);
    // });
    super.initState();
  }

  void _addDoc() {
    final db = FirebaseFirestore.instance;
    db.collection('/users').add({
      'name': 'Tom',
      'age': 27,
      'createdAt': Timestamp.now()
    }).whenComplete(() => print('Success'));
  }

  void _removeDocs() {
    final db = FirebaseFirestore.instance;
    db.collection('/users').get().then((event) {
      for (var doc in event.docs) {
        doc.reference.delete();
      }
    }).then((event) {
      db
          .collection('/users')
          .add({'name': 'Mark', 'age': 25, 'createdAt': Timestamp.now()});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text('Share Cost App')),
          const SizedBox(height: 20.0,),
          const Text('For debug purposes'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: _addDoc,
                  child: const Text('Add the doc to Firebase')),
              ElevatedButton(
                  onPressed: _removeDocs, child: const Text('Remove all docs')),
            ],
          )
        ],
      ),
    );
  }
}
