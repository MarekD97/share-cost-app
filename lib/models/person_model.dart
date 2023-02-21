import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Person {
  String id;
  String name;

  Person({String? id, required this.name}) : id = id ?? uuid.v4();

  static Person fromJson(Map<String, dynamic> json) =>
      Person(id: json['id'], name: json['name']);

  Map<String, dynamic> toJson() => <String, dynamic>{'id': id, 'name': name};
}
