import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_cost_app/models/expense_model.dart';
import 'package:share_cost_app/models/group_model.dart';

class CloudFirebaseService {
  static final CollectionReference groupsCollection =
      FirebaseFirestore.instance.collection('groups');

  static Future<String> createGroup(Group group) async {
    final result = await groupsCollection.add(group.toJson());
    return result.id;
  }

  static Stream<QuerySnapshot> getAllGroups() => groupsCollection.snapshots();

  static Stream<QuerySnapshot> getGroupById(String id) =>
      groupsCollection.where("id", isEqualTo: id).snapshots();

  static Future<void> addExpenseToGroup(String groupId, Expense expense) async {
    final result = await groupsCollection.where("id", isEqualTo: groupId).get();
    result.docs.first.reference.update({
      'expenses':
          FieldValue.arrayUnion(List.generate(1, (index) => expense.toJson()))
    });
  }
}
