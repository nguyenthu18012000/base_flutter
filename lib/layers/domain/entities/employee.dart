import 'package:flutter_core/flutter_core.dart';

class Employee extends Equatable {
  final String? name;
  final int? age;

  const Employee({this.name, this.age});

  @override
  List<Object?> get props => [name, age];
}
