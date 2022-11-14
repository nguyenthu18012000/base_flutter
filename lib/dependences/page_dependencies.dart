import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

import '../architecture/presentation/pages/pages.dart';
import '../constants/constants.dart';

Future<void> config(GetIt injector) async {
  try {
    injector.registerFactory<Widget>(
      () => const EmployeePage(),
      instanceName: RouteConstants.employee,
    );
  } catch (e) {
    dev.log('Config PageDependencies failed');
  }
}
