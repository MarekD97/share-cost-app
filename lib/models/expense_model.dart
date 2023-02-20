import 'package:share_cost_app/models/person_model.dart';

class Expense {
  String name;
  Person paidBy;
  List<Person> paidFor;
  double amountSpent;
  String category;
  DateTime createdAt;

  Expense(
      {required this.name,
      required this.paidBy,
      required this.paidFor,
      required this.amountSpent,
      required this.category,
      required this.createdAt});

  static Expense fromJson(Map<String, dynamic> json) => Expense(
        name: json['name'],
        paidBy: Person.fromJson(json['paidBy']),
        paidFor: List<Person>.from(
            json['paidFor'].map((person) => Person.fromJson(person))),
        amountSpent: json['amountSpent'],
        category: json['category'],
        createdAt: DateTime.parse(json['createdAt'])
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'paidBy': paidBy.toJson(),
        'paidFor': paidFor.map((person) => person.toJson()).toList(),
        'amountSpent': amountSpent,
        'category': category,
        'createdAt': createdAt.toString()
      };
}
