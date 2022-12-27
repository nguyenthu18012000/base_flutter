part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String? errMessage;
  final bool isSuccess;
  final bool isLoading;

  const LoginState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errMessage,
  });

  LoginState copyWith({
    bool isLoading = false,
    bool isSuccess = false,
    String? errMessage,
  }) {
    return LoginState(
      errMessage: errMessage,
      isSuccess: isSuccess,
      isLoading: isLoading,
    );
  }

  @override
  List<Object?> get props => [errMessage, isSuccess, isLoading];
}
