import 'package:places/domain/filter.dart';

/// Интерфейс для хранилища настроек
abstract class StorageRepository {
  /// Последние настройки фильтра
  Filter filter;

  /// Темная тема
  bool isDarkTheme;

  /// Первый запуск
  bool isFirstRun;
}
