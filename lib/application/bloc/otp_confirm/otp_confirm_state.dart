part of 'otp_confirm_bloc.dart';

class OtpConfirmState extends Equatable{
  final bool isLoading;
  final String? errMessage;
  final bool isSuccess;
  final int time;


  const OtpConfirmState({
    this.isLoading = false,
    this.isSuccess =false,
    this.errMessage,
    this.time = 60,

  });

  OtpConfirmState copyWith({
    bool isLoading = false,
    bool isSuccess = false,
    String? errMessage,
    int? time,


  }) {
    return OtpConfirmState(
        isLoading: isLoading,
        errMessage: errMessage,
        isSuccess: isSuccess,
      time: time??this.time
    );
  }

  @override
  List<Object?> get props => [isLoading, errMessage, isSuccess,time];
}

