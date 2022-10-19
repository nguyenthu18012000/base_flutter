import 'package:flutter_core/flutter_core.dart';
import '../../../constants/constants.dart';
import '../models/models.dart';

abstract class EmployeeRemote {
  Future<Either<Failure, List<EmployeeModel>?>> getEmployees();
}

class EmployeeRemoteImpl extends EmployeeRemote {
  final AppClient _appClient;

  EmployeeRemoteImpl(this._appClient);

  @override
  Future<Either<Failure, List<EmployeeModel>?>> getEmployees() async {
    final result = await _appClient.call(ApiConstants.getEmployees,
        method: RestfulMethod.get);

    return result.fold(
      (l) => Left(l),
      (r) {
        if (r is List) {
          return Right(r.map((e) => EmployeeModel.fromJson(e)).toList());
        }
        return const Right(null);
      },
    );
  }
}
