part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent {}

class ChangeAvatarRequest extends EditProfileEvent {}

class SubmitProfileEvent extends EditProfileEvent {}

class OpenImagePicker extends EditProfileEvent {
  final ImageSource? imageSource;

  OpenImagePicker({this.imageSource});
}

class ProvideImagePath extends EditProfileEvent {
  final String? avatarPath;

  ProvideImagePath({this.avatarPath});
}

class SaveProfileChanges extends EditProfileEvent {}
