part of 'create_password_bloc.dart';

@immutable
abstract class CreatePasswordEvent {}

class CreatePasswordInitial extends CreatePasswordEvent {}

class CreateButtonPressed extends CreatePasswordEvent {
  final String password;
  // final String confirmPassword;

  CreateButtonPressed({
    required this.password,
   // required this.confirmPassword,
  });
}
