/// Конфигурация сборки
class BuildConfig {
  BuildConfig({
    this.baseUrl,
    this.debugTitle,
    this.minRange,
    this.maxRange,
  });

  /// Сообщение что используем debug сборку
  final String debugTitle;

  /// URL сервера
  final String baseUrl;

  /// Значения для фильтра.  min max радиусы поиска
  final double minRange;
  final double maxRange;
}
