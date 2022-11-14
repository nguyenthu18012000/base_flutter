import 'package:flutter_core/flutter_core.dart';

import '../constants/constants.dart';
import '../dependences/dependencies.dart' as di;
import 'env_config.dart';

class AppConfig {
  AppConfig._();

  static AppConfig get instance => AppConfig._();

  Future<void> configApp({required Env env}) async {
    await _configEnv(env: env);
    await _configDi();
    _configUI();
  }

  void _configUI() {
    EasyLoading.instance
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  Future _configEnv({required Env env}) async {
    await EnvConfig.instance.load(envStr: env.value);
  }

  Future _configDi() async {
    await di.init();
  }
}
