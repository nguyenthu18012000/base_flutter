import 'package:base_bloc_flutter/application/datasource/datasources.dart';
import 'package:flutter_core/flutter_core.dart';

part 'user_profile_event.dart';

part 'user_profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._userProfileRemote) : super(const ProfileState()) {
    on<GetUserProfileEvent>(_onGetUserProfile);
  }

  final UserProfileRemote _userProfileRemote;
  String userID = '';
  String password = '';
  late User user;

  Future<void> _onGetUserProfile(
      GetUserProfileEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _userProfileRemote.getUserProfile(userID);

    final newState =
        result.fold((l) => state.copyWith(errMessage: l.message), (r) {
      user = r ?? User();
      password = r?.password ?? '';
      return state.copyWith(user: r);
    });
    emit(newState);
  }

  logout() {
    UserInfo.logout();
  }
}
