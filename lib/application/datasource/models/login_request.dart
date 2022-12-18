import 'package:flutter_core/flutter_core.dart';

class LoginRequest extends Equatable {
  final String? username;
  final String? password;

  const LoginRequest({this.username, this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      username: json['username'],
      password: json['password'],
    );
  }

  @override
  List<Object?> get props => [username, password];
}
