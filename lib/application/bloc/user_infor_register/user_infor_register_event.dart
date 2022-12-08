part of 'user_infor_register_bloc.dart';

@immutable
abstract class UserInforRegisterEvent {}

class CheckPrivacyEvent extends UserInforRegisterEvent {
  final bool isChecked;

  CheckPrivacyEvent({required this.isChecked});
}

class SubmitInforPressedEvent extends UserInforRegisterEvent {
  final String name;
  final Gender gender;
  final String dateOfBirth;

  SubmitInforPressedEvent(
      {required this.name, required this.gender, required this.dateOfBirth});
}
