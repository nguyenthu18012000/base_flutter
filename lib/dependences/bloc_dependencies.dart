import 'dart:developer' as dev;
import 'package:flutter_core/flutter_core.dart';

import '../application/bloc/blocs.dart';

Future<void> config(GetIt injector) async {
  try {
    injector.registerFactory<EmployeeBloc>(() => EmployeeBloc(injector()));
    injector.registerFactory<DetailBloc>(() => DetailBloc());
    injector.registerFactory<LoginBloc>(() => LoginBloc());
    injector.registerFactory<RegisterBloc>(() => RegisterBloc());
    injector.registerFactory<CreatePasswordBloc>(() => CreatePasswordBloc());
    injector.registerFactory<OtpConfirmBloc>(() => OtpConfirmBloc());
    injector.registerFactory<UserInforRegisterBloc>(() => UserInforRegisterBloc());
  } catch (e) {
    dev.log('Config BlocDependencies failed');
  }
}
