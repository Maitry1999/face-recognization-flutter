import 'package:attandence_system/domain/core/environment/base_config.dart';
import 'package:attandence_system/domain/core/environment/environment_configs.dart';

class EnvironmentCongig {
  factory EnvironmentCongig() {
    return _singleton;
  }

  EnvironmentCongig._internal();
  static final EnvironmentCongig _singleton = EnvironmentCongig._internal();

  static const String dev = 'dev';
  static const String staging = 'staging';
  static const String prod = 'prod';

  late BaseConfig config;

  void initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case EnvironmentCongig.prod:
        return ProdConfig();
      case EnvironmentCongig.staging:
        return StagingConfig();
      default:
        return DevConfig();
    }
  }
}
