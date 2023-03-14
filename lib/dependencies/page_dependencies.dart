import 'dart:developer' as dev;
import 'package:base_bloc_flutter/application/presentation/pages/change_password/change_password_step_one_page.dart';
import 'package:base_bloc_flutter/application/presentation/pages/change_password/change_password_step_two_page.dart';
import 'package:base_bloc_flutter/application/presentation/pages/profile/edit_profile_page.dart';
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
          () => const EditProfilePage(),
      instanceName: RouteConstants.editProfile,
    );
    injector.registerFactory<Widget>(
          () => const ChangePasswordStepTwoPage(),
      instanceName: RouteConstants.changePasswordStepTwo,
    );
    injector.registerFactory<Widget>(
          () => const ChangePasswordStepOnePage(),
      instanceName: RouteConstants.changePasswordStepOne,
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
    injector.registerFactory<Widget>(
          () => const NotificationPage(),
      instanceName: RouteConstants.notification,
    );
    injector.registerFactory<Widget>(
          () => const HomePage(),
      instanceName: RouteConstants.home,
    );
  } catch (e) {
    dev.log('Config PageDependencies failed');
  }
}
