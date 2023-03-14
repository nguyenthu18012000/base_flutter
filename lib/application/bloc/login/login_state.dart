part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isSuccess;
  final bool isLoading;
  final String? errMessage;
  final String? userId;

  const LoginState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errMessage,
    this.userId,
  });

  LoginState copyWith({
    bool isSuccess = false,
    bool isLoading = false,
    String? errMessage,
    String? userId
  }) {
    return LoginState(
      errMessage: errMessage,
      isSuccess: isSuccess,
      isLoading: isLoading,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [isSuccess, isLoading, errMessage, userId];

}
