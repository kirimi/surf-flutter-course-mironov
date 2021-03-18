import 'package:places/data/database/database.dart';
import 'package:places/model/repository/search_history_repository.dart';

/// Репозиторий для истории поиска. Хранение в базе данных
class SearchHistoryDbRepository implements SearchHistoryRepository {
  final AppDatabase database;

  SearchHistoryDbRepository(this.database);

  /// Добавить в историю.
  ///
  /// Добавляется, как самый первый элемент.
  /// Cтарые запросы стираются, чтобы не повторялись.
  @override
  Future<void> add(String request) async => database.searchHistoryDao.add(request);

  /// Список запросов
  @override
  Future<List<String>> all() => database.searchHistoryDao.getAll();

  /// Очистить всю историю
  @override
  Future<void> clear() async => database.searchHistoryDao.clear();

  /// Удаляет запись из истории по индексу
  @override
  Future<void> remove(String request) => database.searchHistoryDao.remove(request);
}
