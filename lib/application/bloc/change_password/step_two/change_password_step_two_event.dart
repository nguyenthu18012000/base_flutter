part of 'change_password_step_two_bloc.dart';

@immutable
abstract class ChangePasswordStepTwoEvent {}

class ChangePasswordButtonPressed extends ChangePasswordStepTwoEvent {
  final String password;
  // final String confirmPassword;

  ChangePasswordButtonPressed({
    required this.password,
    // required this.confirmPassword,
  });
}
