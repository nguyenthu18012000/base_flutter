import 'package:base_bloc_flutter/application/bloc/blocs.dart';
import 'package:base_bloc_flutter/application/datasource/datasources.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([LoginRemote])
void main() {
  late MockLoginRemote loginRemote;
  late LoginBloc loginBloc;

  setUp(() {
    loginRemote = MockLoginRemote();
    loginBloc = LoginBloc(loginRemote);
  });

  group('LoginBloc', () {
    test('has a correct initialState', () {
      expect(loginBloc.state, const LoginState());
    });

    group('onPress', () {
      String username = 'dinh';
      String password = '123456';
      blocTest(
        'login success',
        setUp: () async {
          when(loginRemote.login(any))
              .thenAnswer((_) => Future.value(const Right('token')));
        },
        build: () => loginBloc,
        act: (LoginBloc bloc) {
          bloc.add(LoginButtonPressed(username: username, password: password));
        },
        expect: () => [
          const LoginState(isLoading: true),
          const LoginState(isLoading: false, isSuccess: true),
        ],
      );
      blocTest(
        'login fail',
        setUp: () async {
          when(loginRemote.login(any))
              .thenAnswer((_) => Future.value(const Left(Failure())));
        },
        build: () => loginBloc,
        act: (LoginBloc bloc) {
          bloc.add(LoginButtonPressed(username: username, password: password));
        },
        expect: () => [
          const LoginState(isLoading: true),
          const LoginState(isLoading: false, isSuccess: false),
        ],
      );
    });
  });
}
