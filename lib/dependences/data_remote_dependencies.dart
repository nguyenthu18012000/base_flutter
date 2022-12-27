import 'dart:developer' as dev;

import 'package:base_bloc_flutter/application/datasource/remotes/login_remote.dart';
import 'package:flutter_core/flutter_core.dart';

import '../application/datasource/datasources.dart';

Future<void> config(GetIt injector) async {
  try {
    injector.registerLazySingleton<EmployeeRemote>(
      () => EmployeeRemote(injector()),
    );
    injector.registerLazySingleton<LoginRemote>(
          () => LoginRemote(injector()),
    );
    injector.registerLazySingleton<ChangePasswordForgotRemote>(
          () => ChangePasswordForgotRemote(injector()),
    );
    injector.registerLazySingleton<RegisterRemote>(
          () => RegisterRemote(injector()),
    );

  } catch (e) {
    dev.log('Config ServiceDependencies failed');
  }
}
