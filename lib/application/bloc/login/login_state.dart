part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String? errMessage;
  final bool isSuccess;


  const LoginState({
    this.isSuccess = false,
    this.errMessage,
  });

  LoginState copyWith({
    bool isSuccess = false,
    String? errMessage,

  }) {
    return LoginState(
        errMessage: errMessage,
        isSuccess: isSuccess,
      );
  }

  @override
  List<Object?> get props => [errMessage, isSuccess];
}
