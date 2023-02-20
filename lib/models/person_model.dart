class Person {
  String name;

  Person({required this.name});

  static fromJson(Map<String, dynamic> json) => Person(name: json['name']);

  Map<String, dynamic> toJson() => <String, dynamic>{'name': name};
}
