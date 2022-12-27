part of 'create_password_bloc.dart';

class CreatePasswordState extends Equatable {
  final String? errMessage;
  final bool isSuccess;
  final String? password;

  const CreatePasswordState({
    this.isSuccess = false,
    this.errMessage,
    this.password,
  });

  CreatePasswordState copyWith({
    bool isSuccess = false,
    String? errMessage,
    String? password,
  }) {
    return CreatePasswordState(
        errMessage: errMessage, isSuccess: isSuccess, password: password);
  }

  @override
  List<Object?> get props => [errMessage, isSuccess, password];
}
