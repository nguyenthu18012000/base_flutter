part of 'user_infor_register_bloc.dart';


class UserInforRegisterState extends Equatable {
  final bool isLoading;
  final String? errMessage;
  final bool isSuccess;
  final bool isReadPrivacy;
  final bool isEnableButton;

  const UserInforRegisterState({
    this.isLoading = false,
    this.isSuccess =false,
    this.errMessage,
    this.isReadPrivacy = false,
    this.isEnableButton = false,

  });

  UserInforRegisterState copyWith({
    bool isLoading = false,
    bool isSuccess = false,
    String? errMessage,
    bool? isReadPrivacy,
    bool? isEnableButton,


  }) {
    return UserInforRegisterState(
        isLoading: isLoading,
        errMessage: errMessage,
        isSuccess: isSuccess,
        isReadPrivacy: isReadPrivacy ?? this.isReadPrivacy,
        isEnableButton: isEnableButton ?? this.isEnableButton
    );
  }

  @override
  List<Object?> get props => [isLoading, errMessage, isSuccess,isReadPrivacy,isEnableButton];

}

