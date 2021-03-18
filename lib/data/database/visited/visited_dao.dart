import 'package:moor/moor.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/database/visited/visited_table.dart';

part 'visited_dao.g.dart';

/// DAO для доступа к таблице Посещенные места
@UseDao(tables: [Visited])
class VisitedDao extends DatabaseAccessor<AppDatabase> with _$VisitedDaoMixin {
  VisitedDao(AppDatabase attachedDatabase) : super(attachedDatabase);

  /// Возвращает спискок id посещенных мест
  Future<Set<int>> getAll() async {
    final items = await select(visited).get();
    return items.map((e) => e.placeId).toSet();
  }

  /// добавляет место [placeId] в список посещенных мест
  Future<int> add(int placeId) {
    return into(visited).insert(
      VisitedCompanion(placeId: Value(placeId)),
    );
  }

  /// Удаляем место [placeId] из таблицы
  Future<void> remove(int placeId) {
    return (delete(visited)
          ..where(
            (tbl) => tbl.placeId.equals(placeId),
          ))
        .go();
  }

  /// Возвращает true, если место [placeId] есть в таблице
  Future<bool> isExist(int placeId) async {
    final item = await (select(visited)
          ..where(
            (tbl) => tbl.placeId.equals(placeId),
          ))
        .getSingle();
    return item != null;
  }
}
