part of 'create_new_password_bloc.dart';

@immutable
abstract class CreateNewPasswordEvent {}

class CreatePasswordButtonPressed extends CreateNewPasswordEvent {
  //final String password;
  // final String confirmPassword;

  CreatePasswordButtonPressed(
      //{required this.password,
    // required this.confirmPassword,}
  );
}
