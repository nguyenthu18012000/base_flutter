import 'package:base_bloc_flutter/application/datasource/datasources.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_remote_test.mocks.dart';

@GenerateMocks([AppClient])
main() {
  late MockAppClient appClient;
  late LoginRemote loginRemote;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    appClient = MockAppClient();
    loginRemote = LoginRemote(appClient);
  });

  group('LoginRemote', () {
    group('login', () {
      test('login success', () async {
        LoginRequest loginRequest =
            const LoginRequest(username: 'user', password: '123456');

        when(appClient.call(
          any,
          method: anyNamed('method'),
          data: anyNamed('data'),
        )).thenAnswer((_) async => const Right({'access_token': 'token'}));

        final result = await loginRemote.login(loginRequest);
        expect(result, const Right('token'));
      });

      test('login fail', () async {
        LoginRequest loginRequest =
            const LoginRequest(username: 'user', password: '123456');
        when(appClient.call(
          any,
          method: anyNamed('method'),
          data: anyNamed('data'),
        )).thenAnswer((_) async => const Left(Failure(code: 201)));

        final result = await loginRemote.login(loginRequest);
        expect(result, const Left(Failure(code: 201)));
      });
    });
  });
}
