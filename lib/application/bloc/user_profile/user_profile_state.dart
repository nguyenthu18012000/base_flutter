part of 'user_profile_bloc.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final String? errMessage;
  final bool isSuccess;
  final User? user;

  const ProfileState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errMessage,
    this.user,
  });

  ProfileState copyWith({
    bool isLoading = false,
    bool isSuccess = false,
    String? errMessage,
    User? user,
  }) {
    return ProfileState(
        isLoading: isLoading,
        errMessage: errMessage,
        isSuccess: isSuccess,
        user: user ?? this.user);
  }

  @override
  List<Object?> get props => [isLoading, errMessage, isSuccess, user];
}
