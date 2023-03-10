import 'dart:developer' as dev;

import 'package:flutter_core/flutter_core.dart';

import '../configs/configs.dart';

Future<void> config(GetIt injector) async {
  try {
    // Network config
    final appInterceptors = [AppInterceptors()];
    final apiUrl = EnvConfig.instance.apiUrl;

    final options = BaseOptions(baseUrl: apiUrl);
    final dio = Dio(options);
    dio.interceptors.addAll(appInterceptors);
    injector.registerLazySingleton<AppClient>(
      () => AppClientImpl(dio: dio),
    );
  } catch (e) {
    dev.log('Config ExternalDependencies failed');
  }
}
