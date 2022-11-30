part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final bool isLoading;
  final String? errMessage;
  final bool isSuccess;
  final String? phoneNumber;

  const RegisterState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errMessage,
    this.phoneNumber,
  });

  RegisterState copyWith({
    bool isLoading = false,
    bool isSuccess = false,
    String? errMessage,
    String? phoneNumber,
  }) {
    return RegisterState(
        isLoading: isLoading,
        errMessage: errMessage,
        isSuccess: isSuccess,
        phoneNumber: phoneNumber);
  }

  @override
  List<Object?> get props => [isLoading, errMessage, isSuccess, phoneNumber];
}
