import 'package:places/environment/build_config.dart';
import 'package:places/environment/build_type.dart';

/// Окружение сборки. синглтон
///
/// для настройки вызвать Environment.init(buildConfig, buildType)
/// далее использовать Environment.instance.buildConfig
class Environment {
  final BuildConfig buildConfig;
  final BuildType buildType;

  static Environment _environment;

  static Environment get instance => _environment;

  Environment._({
    this.buildConfig,
    this.buildType,
  });

  static void init(
    BuildConfig buildConfig,
    BuildType buildType,
  ) {
    _environment = Environment._(
      buildConfig: buildConfig,
      buildType: buildType,
    );
  }
}
