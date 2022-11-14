import 'package:global_configs/global_configs.dart';

class EnvConfig {
  EnvConfig._();

  static EnvConfig get instance => EnvConfig._();

  Future<void> load({required String envStr}) async {
    await GlobalConfigs().loadJsonFromdir('assets/cfg/env_$envStr.json');
  }

  String get apiUrl => GlobalConfigs().get('api_url');
}
