import 'package:base_bloc_flutter/application/datasource/datasources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:meta/meta.dart';

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
  int? userId;

  Future<void> _onPress(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));
    final loginRequest =
        LoginRequest(username: event.username, password: event.password);
    final result = await _loginRemote.login(loginRequest);

    final newState = result.fold(
      (l) => state.copyWith(errMessage: l.message),
      (r) {
        UserInfo.saveTokenInfo(r.accessToken);
        userId = r.userId;
        return state.copyWith(isSuccess: true);
      },
    );
    emit(newState);
  }
}
