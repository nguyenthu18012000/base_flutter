import 'package:base_bloc_flutter/application/datasource/models/models.dart';
import 'package:base_bloc_flutter/application/datasource/remotes/remotes.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:meta/meta.dart';

part 'user_infor_register_event.dart';

part 'user_infor_register_state.dart';

enum Gender { male, female, other }

extension GenderExt on Gender {
  String get value {
    switch (this) {
      case Gender.male:
        return 'MALE';
      case Gender.female:
        return 'FEMALE';
      case Gender.other:
        return 'OTHER';
      default:
        return 'OTHER';
    }
  }
}

class UserInforRegisterArguments {
  final String phoneNumber;
  final String password;

  UserInforRegisterArguments({
    required this.phoneNumber,
    required this.password,
  });
}

class UserInforRegisterBloc
    extends Bloc<UserInforRegisterEvent, UserInforRegisterState> {
  UserInforRegisterBloc(this._registerRemote)
      : super(const UserInforRegisterState()) {
    on<CheckPrivacyEvent>(_checkPrivacy);
    on<SubmitInforPressedEvent>(_onSubmit);
  }

  final RegisterRemote _registerRemote;

  final formUserKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final dateOfBirth = TextEditingController();
  Gender? gender = Gender.male;
  bool isReadPrivacy = false;
  String phoneNumber = '';
  String password = '';

  void _checkPrivacy(
      CheckPrivacyEvent event, Emitter<UserInforRegisterState> emit) {
    isReadPrivacy = event.isChecked;
    emit(state.copyWith(isReadPrivacy: isReadPrivacy));
    bool isOk = isReadPrivacy && formUserKey.currentState!.validate();
    emit(state.copyWith(isEnableButton: isOk));
  }

  Future<void> _onSubmit(SubmitInforPressedEvent event,
      Emitter<UserInforRegisterState> emit) async {
    emit(state.copyWith(isLoading: true));
    late String? deviceToken;
    await FirebaseMessaging.instance.getToken().then((token) {
      deviceToken = token;
    });

    final registerRequest = RegisterRequest(
      username: phoneNumber,
      password: password,
      confirmPassword: password,
      name: event.name,
      gender: event.gender.value,
      dateOfBirth: event.dateOfBirth,
      deviceToken: deviceToken,
    );
    final result = await _registerRemote.register(registerRequest);

    final newState = result.fold(
      (l) => state.copyWith(errMessage: l.message ?? 'error'),
      (r) => state.copyWith(isSuccess: true),
    );
    emit(newState);
    //emit(state.copyWith(isLoading: false, isSuccess: true));
  }

  bool enableSubmit() {
    bool isOk = isReadPrivacy && formUserKey.currentState!.validate();
    return isOk;
  }
}
