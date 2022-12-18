import 'dart:developer' as dev;

import 'package:flutter_core/flutter_core.dart';

import '../application/datasource/datasources.dart';

Future<void> config(GetIt injector) async {
  try {
    injector.registerLazySingleton<EmployeeRemote>(
      () => EmployeeRemote(injector()),
    );
    injector.registerLazySingleton<UserProfileRemote>(
          () => UserProfileRemote(injector()),
    );
  } catch (e) {
    dev.log('Config ServiceDependencies failed');
  }
}
