/// Ключ протух
class CacheEntryExpired implements Exception {}

/// Нет кеша по ключу
class CacheDoesNotExist implements Exception {}

/// Кеш
abstract class CacheRepository {
  /// Добавляет элемент в кеш
  Future<void> add(String key, String data);

  /// Получает элемент из кеша
  Future<String> get(String key);
}
