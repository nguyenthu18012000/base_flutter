import 'package:flutter_core/flutter_core.dart';

import '../../../constants/constants.dart';

class ChangePasswordForgotRemote {
  final AppClient _appClient;

  ChangePasswordForgotRemote(this._appClient);

  Future<Either<Failure, String>> changePasswordForgot(
      String phoneNumber, String password, String passwordConfirm) async {
    final result = await _appClient.call(ApiConstants.changePasswordForgot,
        data: {
          // "phoneNumber": phoneNumber,
          // "password": password
          // "passwordConfirm": passwordConfirm
        },
        method: RestfulMethod.post);

    return result.fold(
      (l) => Left(l),
      (r) {
        return Right(r);
      },
    );
  }
}
