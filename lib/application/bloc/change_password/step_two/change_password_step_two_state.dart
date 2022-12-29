part of 'change_password_step_two_bloc.dart';

class ChangePasswordStepTwoState extends Equatable {
  final String? errMessage;
  final bool isSuccess;
  final String? password;

  const ChangePasswordStepTwoState({
    this.isSuccess = false,
    this.errMessage,
    this.password,
  });

  ChangePasswordStepTwoState copyWith({
    bool isSuccess = false,
    String? errMessage,
    String? password,
  }) {
    return ChangePasswordStepTwoState(
        errMessage: errMessage, isSuccess: isSuccess, password: password);
  }

  @override
  List<Object?> get props => [errMessage, isSuccess, password];
}
