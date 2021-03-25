import 'package:moor/moor.dart';
import 'package:places/data/cache_repository/cache_repository.dart';
import 'package:places/data/database/database.dart';

/// Репозиторий кеша
class CacheRepositoryDb implements CacheRepository {
  static const int cacheTimeMillis = 300000; // 5 мин

  final AppDatabase db;

  CacheRepositoryDb(this.db);

  /// Добавляет элемент key: data в кеш
  @override
  Future<void> add(String key, String data) async {
    await _delete(key);
    final now = DateTime.now().millisecondsSinceEpoch;
    final obj = CacheCompanion(
      created: Value(now),
      key: Value(key),
      value: Value(data),
    );
    return db.into(db.cache).insert(obj);
  }

  /// Загружает элемент из кеша
  /// Если элемент протух, то [CacheEntryExpired]
  /// Если нет такого элемента, то [CacheDoesNotExist]
  @override
  Future<String> get(String key) async {
    final entry = await (db.select(db.cache)
          ..where((tbl) => tbl.key.equals(key))
          ..limit(1))
        .getSingle();

    if (entry == null) {
      throw CacheDoesNotExist();
    }

    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - entry.created > cacheTimeMillis) {
      _delete(key);
      throw CacheEntryExpired();
    }

    return entry.value;
  }

  /// Удаляет из db по ключу
  Future<void> _delete(String key) async {
    return (db.delete(db.cache)
          ..where(
            (tbl) => tbl.key.equals(key),
          ))
        .go();
  }
}
