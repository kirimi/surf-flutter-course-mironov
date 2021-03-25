import 'package:places/data/database/database.dart';
import 'package:places/domain/sight.dart';
import 'package:places/model/repository/favorites_repository.dart';

/// Репозиторий мест "Хочу посетить".
/// Хранилище в db
class FavoritesRepositoryDb implements FavoritesRepository {
  final AppDatabase database;

  FavoritesRepositoryDb(this.database);

  /// Добавляет место с [id] в список "Хочу посетить"
  @override
  Future<void> add(Sight sight) => database.favoritesDao.add(sight);

  /// Возвращает список id мест "Хочу посетить"
  @override
  Future<List<Sight>> getList() => database.favoritesDao.getAll();

  /// Возвращает включено ли место [id] в список "Хочу посетить"
  @override
  Future<bool> isFavorite(int id) => database.favoritesDao.isExist(id);

  /// Удаляет место с [id] из списка "Хочу посетить"
  @override
  Future<void> remove(int id) => database.favoritesDao.remove(id);
}
