/// Хранилище для истории поиска
class SearchHistoryState {
  final List<String> _requests = [];

  /// Получить историю в виде списка строк
  List<String> get list => _requests;

  /// Добавить в историю.
  ///
  /// Добавляется, как самый первый элемент.
  /// Cтарые запросы стираются, чтобы не повторялись.
  void add(String request) {
    _requests.removeWhere((element) => element == request);
    _requests.insert(0, request);
  }

  /// Очистить всю историю
  void clear() => _requests.clear();

  /// Удаляет запись из истории по индексу
  void remove(int index) => _requests.removeAt(index);
}
