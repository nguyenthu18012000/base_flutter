part of 'otp_confirm_bloc.dart';

@immutable
abstract class OtpConfirmEvent {}

class  OtpConfirmInitial extends OtpConfirmEvent {}

class  OtpResendEvent extends OtpConfirmEvent {}

class OtpConfirmPressedEvent extends OtpConfirmEvent{
  final String otp;

  OtpConfirmPressedEvent({required this.otp});

}