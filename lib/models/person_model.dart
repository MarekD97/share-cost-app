class Person {
  String name;

  Person({required this.name});

  static Person fromJson(Map<String, dynamic> json) => Person(name: json['name']);

  Map<String, dynamic> toJson() => <String, dynamic>{'name': name};
}
