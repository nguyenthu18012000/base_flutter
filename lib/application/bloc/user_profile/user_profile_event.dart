part of 'user_profile_bloc.dart';

abstract class ProfileEvent {}

class GetUserProfileEvent extends ProfileEvent {}

class LogoutEvent extends ProfileEvent {}

//   OpenImagePicker({this.imageSource});
// }
//
// class ProvideImagePath extends ProfileEvent {
//   final String avatarPath;
//
//   ProvideImagePath({this.avatarPath});
// }
//
// class ProfileDescriptionChanged extends ProfileEvent {
//   final String description;
//
//   ProfileDescriptionChanged({this.description});
// }
