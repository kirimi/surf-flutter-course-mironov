import 'dart:async';

/// Интерактор для истории поиска
class SearchHistoryInteractor {
  // Хранилище для списка прошлых запросов
  final List<String> _requests = [];

  /// Стрим со списком истории запросов
  final StreamController<List<String>> _requestsStreamController =
      StreamController.broadcast();
  Stream<List<String>> get requestsListStream =>
      _requestsStreamController.stream;

  /// добавляет в стим текущий список истории поиска
  void fetchRequests() {
    _requestsStreamController.sink.add(_requests);
  }

  /// Добавить в историю.
  ///
  /// Добавляется, как самый первый элемент.
  /// Cтарые запросы стираются, чтобы не повторялись.
  void add(String request) {
    _requests.removeWhere((element) => element == request);
    _requests.insert(0, request);
    _requestsStreamController.sink.add(_requests);
  }

  /// Очистить всю историю
  void clear() {
    _requests.clear();
    _requestsStreamController.sink.add(_requests);
  }

  /// Удаляет запись из истории по индексу
  void remove(int index) {
    _requests.removeAt(index);
    _requestsStreamController.sink.add(_requests);
  }
}
