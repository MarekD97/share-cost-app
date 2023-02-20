import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_cost_app/models/expense_list_model.dart';

class CloudFirebaseService {

  static FirebaseFirestore _getInstance() => FirebaseFirestore.instance;

  static Future<String> createExpenseList(ExpenseList expenseList) async {
    final db = _getInstance();
    final result = await db.collection('/expenses').add(expenseList.toJson());
    return result.id;
  }
}