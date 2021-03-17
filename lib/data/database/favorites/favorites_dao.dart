import 'package:moor/moor.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/database/favorites/favorites_table.dart';

part 'favorites_dao.g.dart';

/// DAO для доступа к таблице Избранное
@UseDao(tables: [Favorites])
class FavoritesDao extends DatabaseAccessor<AppDatabase> with _$FavoritesDaoMixin {
  FavoritesDao(AppDatabase attachedDatabase) : super(attachedDatabase);

  /// Возвращает спискок id избранных мест
  Future<Set<int>> getAll() async {
    final items = await select(favorites).get();
    return items.map((e) => e.placeId).toSet();
  }

  /// добавляет место [placeId] в списко Избранное
  Future<int> add(int placeId) {
    return into(favorites).insert(
      FavoritesCompanion(placeId: Value(placeId)),
    );
  }

  /// Удаляем место [placeId] из таблицы
  Future<void> remove(int placeId) {
    return (delete(favorites)
          ..where(
            (tbl) => tbl.placeId.equals(placeId),
          ))
        .go();
  }

  /// Возвращает true, если место [placeId] есть в таблице
  Future<bool> isExist(int placeId) async {
    final item = await (select(favorites)
          ..where(
            (tbl) => tbl.placeId.equals(placeId),
          ))
        .getSingle();
    return item != null;
  }
}
