import 'package:flutter_core/flutter_core.dart';

import '../../../constants/api_constants.dart';

class ChangePasswordStepTwoRemote {
  final AppClient _appClient;

  ChangePasswordStepTwoRemote(this._appClient);

  Future<Either<Failure, int>> changePasswordForgot(
      String oldPassword, String password, String passwordConfirm) async {
    final result = await _appClient.call(ApiConstants.changePassword,
        data: {
          "oldPassword": oldPassword,
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
