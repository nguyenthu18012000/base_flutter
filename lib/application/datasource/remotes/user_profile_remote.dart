import 'package:flutter_core/flutter_core.dart';
import '../../../constants/constants.dart';
import '../models/models.dart';

class UserProfileRemote {
  final AppClient _appClient;

  UserProfileRemote(this._appClient);

  Future<Either<Failure, User?>> getUserProfile(String id) async {
    final queryParameters = <String, dynamic>{r'id': id};
    final result = await _appClient.call(ApiConstants.getUserProfile+id,
        method: RestfulMethod.get, queryParameters: queryParameters);

    return result.fold(
      (l) => Left(l),
      (r) {
        return Right(User.fromJson(r));
      },
    );
  }
}
