

import 'package:flutter/widgets.dart';
import 'package:flutter_core/flutter_core.dart';

import '../../datasource/models/user.dart';
import '../../datasource/remotes/user_profile_remote.dart';
import '../user_infor_register/user_infor_register_bloc.dart';


part 'edit_profile_event.dart';

part 'edit_profile_state.dart';


class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc(this._userProfileRemote) : super(const EditProfileState()) {
    on<SubmitProfileEvent>(_onGetUserProfile);
  }

  final UserProfileRemote _userProfileRemote;
  String userID = '';
  final formUserKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final dateOfBirth = TextEditingController();
  Gender? gender = Gender.male;
  bool isReadPrivacy = false;
  String phoneNumber = '';
  String password = '';

  Future<void> _onGetUserProfile(
      SubmitProfileEvent event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _userProfileRemote.getUserProfile(userID);

    final newState = result.fold(
      (l) => state.copyWith(errMessage: l.message),
      (r) => state.copyWith(user: r),
    );
    emit(newState);
  }
}
