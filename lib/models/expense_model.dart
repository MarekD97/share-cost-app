import 'package:share_cost_app/models/person_model.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Expense {
  String id;
  String name;
  Person paidBy;
  List<Person> paidFor;
  double amountSpent;
  String category;
  DateTime createdAt;

  Expense(
      {String? id,
      required this.name,
      required this.paidBy,
      required this.paidFor,
      required this.amountSpent,
      required this.category,
      required this.createdAt})
      : id = id ?? uuid.v4();

  static Expense fromJson(Map<String, dynamic> json) => Expense(
      id: json['id'],
      name: json['name'],
      paidBy: Person.fromJson(json['paidBy']),
      paidFor: List<Person>.from(
          json['paidFor'].map((person) => Person.fromJson(person))),
      amountSpent: json['amountSpent'],
      category: json['category'],
      createdAt: DateTime.parse(json['createdAt']));

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'paidBy': paidBy.toJson(),
        'paidFor': paidFor.map((person) => person.toJson()).toList(),
        'amountSpent': amountSpent,
        'category': category,
        'createdAt': createdAt.toString()
      };
}
