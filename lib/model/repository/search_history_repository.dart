/// Репозиторий для истории поиска
abstract class SearchHistoryRepository {
  /// Список запросов
  Future<List<String>> all();

  /// Добавить в историю.
  ///
  /// Добавляется, как самый первый элемент.
  /// Cтарые запросы стираются, чтобы не повторялись.
  Future<void> add(String request);

  /// Очистить всю историю
  Future<void> clear();

  /// Удаляет запись из истории по индексу
  Future<void> remove(String request);
}
