import 'dart:io';

import 'package:base_bloc_flutter/application/bloc/user_profile/user_profile_event.dart';
import 'package:base_bloc_flutter/application/bloc/user_profile/user_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../datasource/models/user.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final DataRepository dataRepo;
  final StorageRepository storageRepo;
  final _picker = ImagePicker();

  ProfileBloc({
    @required this.dataRepo,
    @required this.storageRepo,
    @required User user,
    @required bool isCurrentUser,
  }) : super(ProfileState(user: user, isCurrentUser: isCurrentUser)) {
    storageRepo
        .getUrlForFile(user.avatarKey)
        .then((url) => add(ProvideImagePath(avatarPath: url)));
  }

  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ChangeAvatarRequest) {
      yield state.copyWith(imageSourceActionSheetIsVisible: true);
    } else if (event is OpenImagePicker) {
      yield state.copyWith(imageSourceActionSheetIsVisible: false);
      final pickedImage = await _picker.getImage(source: event.imageSource);
      if (pickedImage == null) return;

      final imageKey = await storageRepo.uploadFile(File(pickedImage.path));

      final updatedUser = state.user.copyWith(avatarKey: imageKey);

      final results = await Future.wait([
        dataRepo.updateUser(updatedUser),
        storageRepo.getUrlForFile(imageKey),
      ]);

      yield state.copyWith(avatarPath: results.last);
    } else if (event is ProvideImagePath) {
      yield state.copyWith(avatarPath: event.avatarPath);
    } else if (event is ProfileDescriptionChanged) {
      yield state.copyWith(userDescription: event.description);
    } else if (event is SaveProfileChanges) {
      // handle save changes
    }
  }
}