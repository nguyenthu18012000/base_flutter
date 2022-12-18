part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordEvent {}

class NewPasswordButtonPressed extends ForgotPasswordEvent {
  final String phone;

  NewPasswordButtonPressed({required this.phone});
}
