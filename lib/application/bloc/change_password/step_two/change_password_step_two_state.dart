part of 'change_password_step_two_bloc.dart';

class ChangePasswordStepTwoState extends Equatable {
  final String? errMessage;
  final bool isSuccess;

  const ChangePasswordStepTwoState({
    this.isSuccess = false,
    this.errMessage,
  });

  ChangePasswordStepTwoState copyWith({
    bool isSuccess = false,
    String? errMessage,
  }) {
    return ChangePasswordStepTwoState(
        errMessage: errMessage, isSuccess: isSuccess);
  }

  @override
  List<Object?> get props => [errMessage, isSuccess];
}
