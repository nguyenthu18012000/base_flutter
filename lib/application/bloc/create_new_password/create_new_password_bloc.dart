import 'package:base_bloc_flutter/application/datasource/datasources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

part 'create_new_password_event.dart';

part 'create_new_password_state.dart';

class CreateNewPasswordBloc
    extends Bloc<CreateNewPasswordEvent, CreateNewPasswordState> {
  CreateNewPasswordBloc(this._changePasswordForgotRemote)
      : super(const CreateNewPasswordState()) {
    on<CreatePasswordButtonPressed>(_onPress);
  }

  final ChangePasswordForgotRemote _changePasswordForgotRemote;

  final formCreatePasswordKey = GlobalKey<FormState>();
  final password = TextEditingController();
  final passwordConfirm = TextEditingController();
  String phoneNumber = '';

  Future<void> _onPress(CreatePasswordButtonPressed event,
      Emitter<CreateNewPasswordState> emit) async {
    emit(state.copyWith(isLoading: true));
    final password = event.password;
    final result = await _changePasswordForgotRemote.changePasswordForgot(
        phoneNumber, password, passwordConfirm.text);
    final newState = result.fold(
      (l) => state.copyWith(errMessage: l.message),
      (r) => state.copyWith(isSuccess: true),
    );
    emit(newState);

    //  emit(state.copyWith(isSuccess: true, password: password));
  }
}
