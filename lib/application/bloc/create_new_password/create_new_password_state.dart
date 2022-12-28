part of 'create_new_password_bloc.dart';

class CreateNewPasswordState extends Equatable {
  final bool isLoading;
  final String? errMessage;
  final bool isSuccess;
  final String? password;

  const CreateNewPasswordState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errMessage,
    this.password,
  });

  CreateNewPasswordState copyWith({
    bool isLoading = false,
    bool isSuccess = false,
    String? errMessage,
    String? password,
  }) {
    return CreateNewPasswordState(
        isLoading: isLoading,
        errMessage: errMessage,
        isSuccess: isSuccess,
        password: password);
  }

  @override
  List<Object?> get props => [isLoading, errMessage, isSuccess, password];
}
