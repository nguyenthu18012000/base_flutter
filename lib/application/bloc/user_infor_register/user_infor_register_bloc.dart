import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:meta/meta.dart';

part 'user_infor_register_event.dart';

part 'user_infor_register_state.dart';

enum Gender { male, female, other }

class UserInforRegisterBloc
    extends Bloc<UserInforRegisterEvent, UserInforRegisterState> {
  UserInforRegisterBloc() : super(const UserInforRegisterState()) {
    //on<UserInforRegisterEvent>((event, emit) {});
    on<CheckPrivacyEvent>(_checkPrivacy);
    on<SubmitInforPressedEvent>(_onSubmit);
  }

  final formUserKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final dateOfBirth = TextEditingController();
  Gender? gender = Gender.male;
  bool isReadPrivacy = false;

  void _checkPrivacy(
      CheckPrivacyEvent event, Emitter<UserInforRegisterState> emit) {
    isReadPrivacy = event.isChecked;
    emit(state.copyWith(isReadPrivacy: isReadPrivacy));
  }
  Future<void> _onSubmit(
      SubmitInforPressedEvent event, Emitter<UserInforRegisterState> emit) async {
    emit(state.copyWith(isLoading: true));
    final name = event.name;
    final gender = event.gender;
    final dateOfBirth = event.dateOfBirth;
    print(name);
    print(gender);
    print(dateOfBirth);

    emit(state.copyWith(isLoading: false, isSuccess: true));
  }

  bool enableSubmit(){
    bool isOk = isReadPrivacy&&formUserKey.currentState!.validate();
    return isOk;
  }
}
