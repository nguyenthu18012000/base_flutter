import 'dart:developer' as dev;

import 'package:flutter_core/flutter_core.dart';
import '../layers/data/datas.dart';
import '../layers/domain/domains.dart';

Future<void> config(GetIt injector) async {
  try {
    injector.registerLazySingleton<EmployeeRepository>(
      () => EmployeeRepositoryImpl(injector()),
    );
  } catch (e) {
    dev.log('Config ServiceDependencies failed');
  }
}
