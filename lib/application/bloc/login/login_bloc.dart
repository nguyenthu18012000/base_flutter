import 'package:base_bloc_flutter/application/datasource/datasources.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

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
  String? userId;
  String? deviceToken;

  Future<void> _onPress(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));
    await FirebaseMessaging.instance.getToken().then((token) {
      deviceToken = token;
    });
    final loginRequest =
        LoginRequest(username: event.username, password: event.password);
    final result = await _loginRemote.login(loginRequest);

    final newState = result.fold(
      (l) => state.copyWith(errMessage: l.message),
      (r) {
        UserInfo.saveTokenInfo(r.accessToken);
        userId = "${r.userId}";
        return state.copyWith(isSuccess: true);
      },
    );

    if (userId != null && deviceToken != null) {
      await _loginRemote.subscribe(int.parse(userId!), deviceToken!);
    }

    emit(newState);
  }
}
