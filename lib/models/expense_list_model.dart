import 'package:share_cost_app/models/expense_model.dart';
import 'package:share_cost_app/models/person_model.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ExpenseList {
  String id;
  List<Expense> expenses;
  List<Person> members;
  DateTime createdAt;

  ExpenseList(
      {String? id,
      required this.expenses,
      required this.members,
      required this.createdAt})
      : id = id ?? uuid.v4();

  static ExpenseList fromJson(Map<String, dynamic> json) => ExpenseList(
      id: json['id'],
      expenses: List.from(
          json['expenses'].map((expense) => Expense.fromJson(expense))),
      members:
          List.from(json['members'].map((member) => Person.fromJson(member))),
      createdAt: DateTime.parse(json['createdAt']));

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'expenses': expenses.map((expense) => expense.toJson()).toList(),
        'members': members.map((member) => member.toJson()).toList(),
        'createdAt': createdAt.toString()
      };
}
