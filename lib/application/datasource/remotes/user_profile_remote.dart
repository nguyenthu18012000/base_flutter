import 'package:flutter_core/flutter_core.dart';
import '../../../constants/constants.dart';
import '../models/models.dart';

class UserProfileRemote {
  final AppClient _appClient;

  UserProfileRemote(this._appClient);

  @override
  Future<Either<Failure, User?>> getEmployees() async {
    final result = await _appClient.call(ApiConstants.getEmployees,
        method: RestfulMethod.get);

    return result.fold(
      (l) => Left(l),
      (r) {
          return Right(r.map((e) => Employee.fromJson(e)).toList());
      },
    );
  }
}
