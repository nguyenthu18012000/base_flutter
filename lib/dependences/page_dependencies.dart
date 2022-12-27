import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

import '../application/presentation/pages/pages.dart';
import '../constants/constants.dart';

Future<void> config(GetIt injector) async {
  try {
    injector.registerFactory<Widget>(
      () => const EmployeePage(),
      instanceName: RouteConstants.employee,
    );
    injector.registerFactory<Widget>(
      () => const DetailPage(),
      instanceName: RouteConstants.detail,
    );
    injector.registerFactory<Widget>(
      () => const LoginPage(),
      instanceName: RouteConstants.login,
    );
    injector.registerFactory<Widget>(
          () => const ProfilePage(),
      instanceName: RouteConstants.userProfile,
    );
    injector.registerFactory<Widget>(
          () => const RegisterPage(),
      instanceName: RouteConstants.register,
    );
    injector.registerFactory<Widget>(
          () => const OtpConfirmPage(),
      instanceName: RouteConstants.otpConfirm,
    );
    injector.registerFactory<Widget>(
          () => const CreatePasswordPage(),
      instanceName: RouteConstants.createPassword,
    );
    injector.registerFactory<Widget>(
          () => const UserInforPage(),
      instanceName: RouteConstants.userInforRegister,
    );
    injector.registerFactory<Widget>(
          () => const ForgotPasswordPage(),
      instanceName: RouteConstants.forgotPassword,
    );
    injector.registerFactory<Widget>(
          () => const CreateNewPasswordPage(),
      instanceName: RouteConstants.createNewPassword,
    );
  } catch (e) {
    dev.log('Config PageDependencies failed');
  }
}
