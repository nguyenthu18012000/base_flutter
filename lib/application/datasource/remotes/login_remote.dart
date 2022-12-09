import 'package:flutter_core/flutter_core.dart';
import '../../../constants/constants.dart';
import '../models/models.dart';

class LoginRemote {
  final AppClient _appClient;

  LoginRemote(this._appClient);

  @override
  Future<Either<Failure, String>> login(LoginRequest loginRequest) async {
    final result = await _appClient.call(ApiConstants.login,
        data: {
          "username": loginRequest.username,
          "password": loginRequest.password
        },
        method: RestfulMethod.post);

    return result.fold(
          (l) => Left(l),
          (r) {
            final token =  (r as Map<String, dynamic>)['access_token'];
            UserInfo.saveTokenInfo(token);
        return Right(token);
      },
    );
  }
}
