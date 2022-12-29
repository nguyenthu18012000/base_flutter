import 'package:flutter_core/flutter_core.dart';

class User extends Equatable {
  final String? name;
  final String? password;
  final int? phoneNumber;
  final String? gender;
  final String? dateOfBirth;
  final String? avatar;

  const User(
      {this.name,
      this.phoneNumber,
      this.password,
      this.gender,
      this.dateOfBirth,
      this.avatar});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        gender: json['gender'],
        password: json['password'],
        dateOfBirth: json['dateOfBirth'],
        avatar: json['avatar']);
  }

  @override
  List<Object?> get props => [name, phoneNumber, gender, dateOfBirth, avatar];
}
