/// Репозиторий для истории поиска
class SearchHistoryRepository {
  // Хранилище для списка прошлых запросов
  final List<String> _requests = [];

  /// Список запросов
  List<String> get requests => _requests;

  /// Добавить в историю.
  ///
  /// Добавляется, как самый первый элемент.
  /// Cтарые запросы стираются, чтобы не повторялись.
  void add(String request) {
    remove(request);
    _requests.insert(0, request);
  }

  /// Очистить всю историю
  void clear() {
    _requests.clear();
  }

  /// Удаляет запись из истории по индексу
  void remove(String request) {
    _requests.removeWhere((element) => element == request);
  }
}
