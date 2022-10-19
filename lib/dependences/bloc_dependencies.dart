import 'dart:developer' as dev;
import 'package:flutter_core/flutter_core.dart';

import '../layers/application/blocs/blocs.dart';

Future<void> config(GetIt injector) async {
  try {
    injector.registerFactory<EmployeeBloc>(() => EmployeeBloc(injector()));
  } catch (e) {
    dev.log('Config BlocDependencies failed');
  }
}