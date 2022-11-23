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
  } catch (e) {
    dev.log('Config PageDependencies failed');
  }
}
