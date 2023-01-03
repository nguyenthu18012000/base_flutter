
import 'package:flutter_core/flutter_core.dart';

import '../../../constants/api_constants.dart';

class ChangePasswordStepOneRemote {
  final AppClient _appClient;

  ChangePasswordStepOneRemote(this._appClient);

  Future<Either<Failure, int>> changePasswordForgot(
      String phoneNumber, String password, String passwordConfirm) async {
    final result = await _appClient.call(ApiConstants.changePasswordForgot,
        data: {
          "username": phoneNumber,
          "newPassword": password,
          "confirmNewPassword": passwordConfirm
        },
        method: RestfulMethod.post);

    return result.fold(
      (l) => Left(l),
      (r) {
        return const Right(1);
      },
    );
  }
}
