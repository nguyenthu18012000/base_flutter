import 'package:base_bloc_flutter/application/bloc/blocs.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:base_bloc_flutter/utils/extensions/datetime_extension.dart';

import '../../datasource/models/user.dart';
import '../../datasource/remotes/edit_profile_remote.dart';
import '../user_infor_register/user_infor_register_bloc.dart';

part 'edit_profile_event.dart';

part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc(this._editProfileRemote) : super(const EditProfileState()) {
    on<FillEditProfileEvent>(_onFillDataEditProfile);
    on<OpenImagePicker>(_onUploadAvatar);
    on<SubmitProfileEvent>(_onUpdateUserProfile);
  }

  final EditProfileRemote _editProfileRemote;
  String userID = '';
  final formUserKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final dateOfBirth = TextEditingController();
  final userName = TextEditingController();
  Gender? gender = Gender.male;
  late User user;

  void _onFillDataEditProfile(
      FillEditProfileEvent event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(user: user));
  }

  updateUserProfile(User user) {
    this.user = user;
    name.text = user.name ?? '';
    dateOfBirth.text = user.dateOfBirth?.dateTimeToDDMMYYYY ?? '';
    userName.text = user.username ?? '';
    gender = user.genderValue;
  }

  Future<void> _onUploadAvatar(
      OpenImagePicker event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result =
        await _editProfileRemote.uploadAvatar(event.imageSource ?? '');
    final newState = result.fold(
      (l) => state.copyWith(errMessage: l.message),
      (r) {
        user.avatar = r;
        return state.copyWith(isSuccess: true, avatar: r);
      },
    );
    emit(newState);
  }

  Future<void> _onUpdateUserProfile(
      SubmitProfileEvent event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(isLoading: true));
    user.name = name.text;
    user.username = userName.text;
    user.gender = gender?.value;
    user.dateOfBirth = DateFormat("dd/MM/yyyy").parse(dateOfBirth.text);
    final result = await _editProfileRemote.updateUserProfile(user);
    final newState = result.fold(
      (l) => state.copyWith(errMessage: l.message),
      (r) => state.copyWith(isSuccess: true),
    );
    emit(newState);
  }
}
