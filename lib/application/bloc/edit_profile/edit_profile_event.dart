part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent {}

class ChangeAvatarRequest extends EditProfileEvent {}

class SubmitProfileEvent extends EditProfileEvent {
  final User? user;

  SubmitProfileEvent(this.user);
}

class OpenImagePicker extends EditProfileEvent {
  final String? imageSource;

  OpenImagePicker({this.imageSource});
}

class FillEditProfileEvent extends EditProfileEvent {}

class ProvideImagePath extends EditProfileEvent {
  final String? avatarPath;

  ProvideImagePath({this.avatarPath});
}

class SaveProfileChanges extends EditProfileEvent {}
