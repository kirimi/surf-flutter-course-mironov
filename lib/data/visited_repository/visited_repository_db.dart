import 'package:places/data/database/database.dart';
import 'package:places/model/repository/visited_repository.dart';

/// Репозиторий мест "Посещенные".
class VisitedRepositoryDb implements VisitedRepository {
  final AppDatabase database;

  VisitedRepositoryDb(this.database);

  /// Возвращает список id мест "Посещенные"
  @override
  Future<Set<int>> getList() => database.visitedDao.getAll();

  /// Добавляет место с [id] в список "Посещенные"
  @override
  Future<void> add(int id) => database.visitedDao.add(id);

  /// Удаляет место с [id] из списка "Посещенные"
  @override
  Future<void> remove(int id) => database.visitedDao.remove(id);

  /// Возвращает включено ли место [id] в список "Посещенные"
  @override
  Future<bool> isVisited(int id) => database.visitedDao.isExist(id);
}
