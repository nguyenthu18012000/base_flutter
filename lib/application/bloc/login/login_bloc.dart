import 'package:base_bloc_flutter/application/datasource/datasources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRemote _loginRemote;
  LoginBloc(this._loginRemote)
      : super(const LoginState()) {
    on<LoginButtonPressed>(_onPress);
  }

  Future<void> _onPress (
      LoginButtonPressed event,
      Emitter<LoginState> emit
  ) async {
    if (event.email == "nguyenthu@gmail.com" && event.password == "123456") {
      emit(state.copyWith(isSuccess: true));
    } else {
      emit(state.copyWith(isSuccess: false));
    }
  }
}
