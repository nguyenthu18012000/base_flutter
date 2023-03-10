import 'dart:developer' as dev;

import 'package:flutter_core/flutter_core.dart';

import '../application/datasource/datasources.dart';
import '../application/datasource/remotes/change_password_step_one_remote.dart';

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
    injector.registerLazySingleton<UserProfileRemote>(
          () => UserProfileRemote(injector()),
    );
    injector.registerLazySingleton<EditProfileRemote>(
          () => EditProfileRemote(injector()),
    );
    injector.registerLazySingleton<ChangePasswordStepTwoRemote>(
          () => ChangePasswordStepTwoRemote(injector()),
    );
    injector.registerLazySingleton<ChangePasswordStepOneRemote>(
          () => ChangePasswordStepOneRemote(injector()),
    );
    injector.registerLazySingleton<NotificationRemote>(
          () => NotificationRemote(injector()),
    );
  } catch (e) {
    dev.log('Config ServiceDependencies failed');
  }
}
