import 'package:flutter_core/flutter_core.dart';
import '../../../constants/constants.dart';
import '../models/models.dart';

class LoginRemote {
  final AppClient _appClient;

  LoginRemote(this._appClient);

  Future<Either<Failure, LoginResponse>> login(LoginRequest loginRequest) async {
    final result = await _appClient.call(ApiConstants.login,
        data: {
          "username": loginRequest.username,
          "password": loginRequest.password
        },
        method: RestfulMethod.post);

    return result.fold(
          (l) => Left(l),
          (r) {
        //     final token =  (r as Map<String, dynamic>)['access_token'];
        //     UserInfo.saveTokenInfo(token);
        // return Right(token);
            return Right(LoginResponse.fromJson(r));
      },
    );
  }


  Future<Either<Failure, dynamic>> subscribe(int id, String deviceToken) async {
    final result = await _appClient.call(
      ApiConstants.subscribeFirebase,
      method: RestfulMethod.post,
      data: {
        'deviceToken': deviceToken,
        'userId':id
      },
    );
    return result.fold(
          (l) => Left(l),
          (r) {
        return const Right(true);
      },
    );
  }


  Future<Either<Failure, dynamic>> unsubscribe(int id, String deviceToken) async {
    final result = await _appClient.call(
      ApiConstants.subscribeFirebase,
      method: RestfulMethod.post,
      data: {
        'deviceToken': deviceToken,
        'userId':id
      },
    );
    return result.fold(
          (l) => Left(l),
          (r) {
        return const Right(true);
      },
    );
  }

}
