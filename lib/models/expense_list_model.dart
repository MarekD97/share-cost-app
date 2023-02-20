import 'package:share_cost_app/models/expense_model.dart';
import 'package:share_cost_app/models/person_model.dart';

class ExpenseList {
  List<Expense> expenses;
  List<Person> members;
  DateTime createdAt;

  ExpenseList(
      {required this.expenses, required this.members, required this.createdAt});

  static fromJson(Map<String, dynamic> json) => ExpenseList(
      expenses: List.from(
          json['expenses'].map((expense) => Expense.fromJson(expense))),
      members:
          List.from(json['members'].map((member) => Person.fromJson(member))),
      createdAt: DateTime(json['createdAt']));

  Map<String, dynamic> toJson() => <String, dynamic>{
        'expenses': expenses.map((expense) => expense.toJson()).toList(),
        'members': members.map((member) => member.toJson()).toList(),
        'createdAt': createdAt.toString()
      };
}
