import 'package:base_bloc_flutter/application/datasource/datasources.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:meta/meta.dart';

import '../../datasource/remotes/login_remote.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._loginRemote) : super(const LoginState()) {
    on<LoginButtonPressed>(_onPress);
  }

  final LoginRemote _loginRemote;

  final formLoginKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();

  Future<void> _onPress(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    final loginRequest =
        LoginRequest(username: event.username, password: event.password);
    final result = await _loginRemote.login(loginRequest);

    final newState = result.fold(
      (l) => state.copyWith(errMessage: l.message),
      (r) => state.copyWith(isSuccess: true),
    );
    emit(newState);
  }
}
