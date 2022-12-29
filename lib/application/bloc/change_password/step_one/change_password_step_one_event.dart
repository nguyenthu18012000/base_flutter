part of 'change_password_step_one_bloc.dart';

@immutable
abstract class ChangePasswordStepOneEvent {}

class ChangePasswordStepOnePressed extends ChangePasswordStepOneEvent {
  final String password;
  // final String confirmPassword;

  ChangePasswordStepOnePressed({
    required this.password,
    // required this.confirmPassword,
  });
}
