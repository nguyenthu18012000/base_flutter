import 'package:base_bloc_flutter/application/datasource/models/models.dart';
import 'package:flutter_core/flutter_core.dart';

import '../../../constants/constants.dart';

class RegisterRemote {
  final AppClient _appClient;

  RegisterRemote(this._appClient);

  Future<Either<Failure, int>> register(RegisterRequest registerRequest) async {
    final result = await _appClient.call(ApiConstants.register,
        data: registerRequest.toJson(), method: RestfulMethod.post);

    return result.fold(
      (l) => Left(l),
      (r) {
        return Right(1);
      },
    );
  }
}
