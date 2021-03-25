import 'dart:convert';

import 'package:moor/moor.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/database/visited/visited_table.dart';
import 'package:places/domain/sight.dart';

part 'visited_dao.g.dart';

/// DAO для доступа к таблице Посещенные места
@UseDao(tables: [Visited])
class VisitedDao extends DatabaseAccessor<AppDatabase> with _$VisitedDaoMixin {
  VisitedDao(AppDatabase attachedDatabase) : super(attachedDatabase);

  /// Возвращает спискок посещенных мест
  Future<List<Sight>> getAll() async {
    final items = await select(visited).get();
    return items
        .map((e) => Sight.fromJson(jsonDecode(e.sight) as Map<String, dynamic>))
        .toList();
  }

  /// добавляет место [sight] в список посещенных мест
  Future<int> add(Sight sight) {
    return into(visited).insert(
      VisitedCompanion(
        placeId: Value(sight.id),
        sight: Value(jsonEncode(sight.toJson())),
      ),
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
