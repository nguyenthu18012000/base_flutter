part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class StartEvent extends RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {
  final String phone;
  RegisterButtonPressed(
      {required this.phone});
}