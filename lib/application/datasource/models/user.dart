import 'package:flutter_core/flutter_core.dart';

class User extends Equatable {
  final String? name;
  final int? phoneNumber;
  final String? gender;
  final String? dateOfBirth;
  final String? language;
  final String? avatarPath;

  const User(
      {this.name,
      this.phoneNumber,
      this.gender,
      this.dateOfBirth,
      this.language,
      this.avatarPath});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        gender: json['gender'],
        dateOfBirth: json['dateOfBirth'],
        language: json['language'],
        avatarPath: json['avatarPath']);
  }

  @override
  List<Object?> get props =>
      [name, phoneNumber, gender, dateOfBirth, language, avatarPath];
}
