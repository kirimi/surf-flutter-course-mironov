import 'package:places/model/repository/search_history_repository.dart';

/// Репозиторий для истории поиска. Хранение в памяти
class SearchHistoryMemoryRepository implements SearchHistoryRepository {
  // Хранилище для списка прошлых запросов
  final List<String> _requests = [];

  /// Список запросов
  @override
  Future<List<String>> all() {
    return Future.value(_requests);
  }

  /// Добавить в историю.
  ///
  /// Добавляется, как самый первый элемент.
  /// Cтарые запросы стираются, чтобы не повторялись.
  @override
  Future<void> add(String request) async {
    remove(request);
    _requests.insert(0, request);
  }

  /// Очистить всю историю
  @override
  Future<void> clear() async {
    _requests.clear();
  }

  /// Удаляет запись из истории по индексу
  @override
  Future<void> remove(String request) async {
    _requests.removeWhere((element) => element == request);
  }
}
