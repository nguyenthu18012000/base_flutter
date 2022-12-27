part of 'user_infor_register_bloc.dart';


class UserInforRegisterState extends Equatable {
  final bool isLoading;
  final String? errMessage;
  final bool isSuccess;
  final bool isReadPrivacy;

  const UserInforRegisterState({
    this.isLoading = false,
    this.isSuccess =false,
    this.errMessage,
    this.isReadPrivacy = false,

  });

  UserInforRegisterState copyWith({
    bool isLoading = false,
    bool isSuccess = false,
    String? errMessage,
    bool? isReadPrivacy,


  }) {
    return UserInforRegisterState(
        isLoading: isLoading,
        errMessage: errMessage,
        isSuccess: isSuccess,
        isReadPrivacy: isReadPrivacy ?? this.isReadPrivacy
    );
  }

  @override
  List<Object?> get props => [isLoading, errMessage, isSuccess,isReadPrivacy];

}

