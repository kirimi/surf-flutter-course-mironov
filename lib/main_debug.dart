import 'package:places/app.dart';
import 'package:places/environment/build_config.dart';
import 'package:places/environment/build_type.dart';
import 'package:places/environment/environment.dart';

/// Сборка для разработки
Future<void> main() async {
  Environment.init(
      BuildConfig(
        debugTitle: 'Debug сборка приложения',
        baseUrl: 'https://test-backend-flutter.surfstudio.ru',
        minRange: 100.0,
        maxRange: 5000000.0,
      ),
      BuildType.debug);

  run();
}
