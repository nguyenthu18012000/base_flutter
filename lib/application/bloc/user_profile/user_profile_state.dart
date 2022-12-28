part of 'user_profile_bloc.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final String? errMessage;
  final bool isSuccess;
  final bool isReadPrivacy;
  final User user;

  const ProfileState({
    this.isLoading = false,
    this.isSuccess =false,
    this.errMessage,
    this.isReadPrivacy = false,
    this.user

  });

  ProfileState copyWith({
    bool isLoading = false,
    bool isSuccess = false,
    String? errMessage,
    bool? isReadPrivacy,


  }) {
    return ProfileState(
        isLoading: isLoading,
        errMessage: errMessage,
        isSuccess: isSuccess,
        isReadPrivacy: isReadPrivacy ?? this.isReadPrivacy
    );
  }

  @override
  List<Object?> get props => [isLoading, errMessage, isSuccess,isReadPrivacy];

}