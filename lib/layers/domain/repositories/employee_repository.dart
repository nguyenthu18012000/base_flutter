import 'package:flutter_core/flutter_core.dart';

import '../domains.dart';

abstract class EmployeeRepository {
  Future<Either<Failure, List<Employee>?>> getEmployees();
}
