part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent {}

class ChangeAvatarRequest extends EditProfileEvent {}

class SubmitProfileEvent extends EditProfileEvent {
}
class OpenImagePicker extends EditProfileEvent {
  final ImageSource? imageSource;

  OpenImagePicker({this.imageSource});
}
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

class SaveProfileChanges extends EditProfileEvent {}
