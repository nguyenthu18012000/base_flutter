part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  final bool isLoading;
  final String? errMessage;
  final bool isSuccess;
  final User? user;
  final String? avatar;

  const EditProfileState(
      {this.isLoading = false,
      this.isSuccess = false,
      this.errMessage,
      this.user,
      this.avatar});

  EditProfileState copyWith({
    bool isLoading = false,
    bool isSuccess = false,
    String? errMessage,
    User? user,
    String? avatar,
  }) {
    return EditProfileState(
        isLoading: isLoading,
        errMessage: errMessage,
        isSuccess: isSuccess,
        user: user ?? this.user,
        avatar: avatar);
  }

  @override
  List<Object?> get props => [isLoading, errMessage, isSuccess, user, avatar];
}
