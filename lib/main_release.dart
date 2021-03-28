import 'package:places/app.dart';
import 'package:places/environment/build_config.dart';
import 'package:places/environment/build_type.dart';
import 'package:places/environment/environment.dart';

/// Релизная сборка
Future<void> main() async {
  Environment.init(
      BuildConfig(
        debugTitle: '',
        baseUrl: 'https://test-backend-flutter.surfstudio.ru',
        minRange: 100.0,
        maxRange: 100000.0,
      ),
      BuildType.release);

  run();
}
