part of 'create_new_password_bloc.dart';

class CreateNewPasswordState extends Equatable {
  final String? errMessage;
  final bool isSuccess;
  final String? password;

  const CreateNewPasswordState({
    this.isSuccess = false,
    this.errMessage,
    this.password,
  });

  CreateNewPasswordState copyWith({
    bool isSuccess = false,
    String? errMessage,
    String? password,
  }) {
    return CreateNewPasswordState(
        errMessage: errMessage, isSuccess: isSuccess, password: password);
  }

  @override
  List<Object?> get props => [errMessage, isSuccess, password];
}
