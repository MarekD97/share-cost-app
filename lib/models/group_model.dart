import 'package:share_cost_app/models/person_model.dart';
import 'package:share_cost_app/models/expense_model.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Group {
  final String id;
  final String name;
  final List<Expense> expenses;
  final List<Person> members;
  final DateTime createdAt;

  Group(
      {String? id,
      required this.name,
      required this.expenses,
      required this.members,
      required this.createdAt})
      : id = id ?? uuid.v4();

  static Group fromJson(Map<String, dynamic> json) => Group(
      id: json['id'],
      name: json['name'],
      expenses: List.from(
          json['expenses'].map((expense) => Expense.fromJson(expense))),
      members:
          List.from(json['members'].map((member) => Person.fromJson(member))),
      createdAt: DateTime.parse(json['createdAt']));

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'expenses': expenses.map((expense) => expense.toJson()).toList(),
        'members': members.map((member) => member.toJson()).toList(),
        'createdAt': createdAt.toString()
      };
}
