import '../../domain/domains.dart';

class EmployeeModel extends Employee {
  @override
  final String? name;

  @override
  final int? age;

  const EmployeeModel({this.name, this.age});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      name: json['name'],
      age: json['age'],
    );
  }
}
