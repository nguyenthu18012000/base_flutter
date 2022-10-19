import 'dart:developer' as dev;

import 'package:flutter_core/flutter_core.dart';
import '../layers/data/datas.dart';

Future<void> config(GetIt injector) async {
  try {
    injector.registerLazySingleton<EmployeeRemote>(
      () => EmployeeRemoteImpl(injector()),
    );
  } catch (e) {
    dev.log('Config ServiceDependencies failed');
  }
}
