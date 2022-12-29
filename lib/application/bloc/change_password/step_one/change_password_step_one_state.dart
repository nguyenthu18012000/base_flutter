part of 'change_password_step_one_bloc.dart';

class ChangePasswordStepOneState extends Equatable {
  final String? errMessage;
  final bool isSuccess;
  final String? password;

  const ChangePasswordStepOneState({
    this.isSuccess = false,
    this.errMessage,
    this.password,
  });

  ChangePasswordStepOneState copyWith({
    bool isSuccess = false,
    String? errMessage,
    String? password,
  }) {
    return ChangePasswordStepOneState(
        errMessage: errMessage, isSuccess: isSuccess, password: password);
  }

  @override
  List<Object?> get props => [errMessage, isSuccess, password];
}
