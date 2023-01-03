import 'package:base_bloc_flutter/application/datasource/datasources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

part 'change_password_step_two_event.dart';

part 'change_password_step_two_state.dart';

class ChangePasswordStepTwoBloc
    extends Bloc<ChangePasswordStepTwoEvent, ChangePasswordStepTwoState> {
  ChangePasswordStepTwoBloc(this._changePasswordStepTwoRemote)
      : super(const ChangePasswordStepTwoState()) {
    on<ChangePasswordButtonPressed>(_onPress);
  }

  final ChangePasswordStepTwoRemote _changePasswordStepTwoRemote;

  final formCreatePasswordKey = GlobalKey<FormState>();
  final password = TextEditingController();
  final passwordConfirm = TextEditingController();
  String currentPassword = '';

  Future<void> _onPress(ChangePasswordButtonPressed event,
      Emitter<ChangePasswordStepTwoState> emit) async {
    final password = event.password;
    final result = await _changePasswordStepTwoRemote.changePasswordForgot(
        currentPassword, password, passwordConfirm.text);
    final newState = result.fold(
      (l) => state.copyWith(errMessage: l.message),
      (r) => state.copyWith(isSuccess: true),
    );
    emit(newState);

  //  emit(state.copyWith(isSuccess: true, password: password));
  }
}
