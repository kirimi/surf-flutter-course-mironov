import 'package:places/data/database/database.dart';
import 'package:places/domain/sight.dart';
import 'package:places/model/repository/visited_repository.dart';

/// Репозиторий мест "Посещенные".
class VisitedRepositoryDb implements VisitedRepository {
  final AppDatabase database;

  VisitedRepositoryDb(this.database);

  /// Возвращает список id мест "Посещенные"
  @override
  Future<List<Sight>> getList() => database.visitedDao.getAll();

  /// Добавляет место [sight] в список "Посещенные"
  @override
  Future<void> add(Sight sight) => database.visitedDao.add(sight);

  /// Удаляет место с [id] из списка "Посещенные"
  @override
  Future<void> remove(int id) => database.visitedDao.remove(id);

  /// Возвращает включено ли место [id] в список "Посещенные"
  @override
  Future<bool> isVisited(int id) => database.visitedDao.isExist(id);
}
