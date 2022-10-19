import 'package:flutter_core/flutter_core.dart';
import '../../domain/domains.dart';
import '../remotes/remotes.dart';

class EmployeeRepositoryImpl extends EmployeeRepository {
  final EmployeeRemote remote;

  EmployeeRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, List<Employee>?>> getEmployees() {
    return remote.getEmployees();
  }
}
