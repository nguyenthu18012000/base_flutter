import 'package:flutter_core/flutter_core.dart';

class User extends Equatable {
  final String? name;
  final int? phoneNumber;
  final String? gender;
  final String? dateOfBirth;
  final String? language;

  const User({this.name, this.phoneNumber,this.gender,this.dateOfBirth,this.language});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      language: json['language'],
    );
  }

  @override
  List<Object?> get props => [name, phoneNumber,gender,dateOfBirth,language];
}
