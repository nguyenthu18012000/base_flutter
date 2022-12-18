part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  final bool isLoading;
  final String? errMessage;
  final bool isSuccess;
  final String? phoneNumber;

  const ForgotPasswordState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errMessage,
    this.phoneNumber,
  });

  ForgotPasswordState copyWith({
    bool isLoading = false,
    bool isSuccess = false,
    String? errMessage,
    String? phoneNumber,
  }) {
    return ForgotPasswordState(
        isLoading: isLoading,
        errMessage: errMessage,
        isSuccess: isSuccess,
        phoneNumber: phoneNumber);
  }

  @override
  List<Object?> get props => [isLoading, errMessage, isSuccess, phoneNumber];
}
