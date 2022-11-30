part of 'otp_confirm_bloc.dart';

class OtpConfirmState extends Equatable{
  final bool isLoading;
  final String? errMessage;
  final bool isSuccess;


  const OtpConfirmState({
    this.isLoading = false,
    this.isSuccess =false,
    this.errMessage,


  });

  OtpConfirmState copyWith({
    bool isLoading = false,
    bool isSuccess = false,
    String? errMessage,


  }) {
    return OtpConfirmState(
        isLoading: isLoading,
        errMessage: errMessage,
        isSuccess: isSuccess,
    );
  }

  @override
  List<Object?> get props => [isLoading, errMessage, isSuccess];
}

