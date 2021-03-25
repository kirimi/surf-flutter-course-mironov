import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:places/data/database/cache/cache_table.dart';
import 'package:places/data/database/favorites/favorites_dao.dart';
import 'package:places/data/database/favorites/favorites_table.dart';
import 'package:places/data/database/search_history/search_history_dao.dart';
import 'package:places/data/database/search_history/search_history_table.dart';
import 'package:places/data/database/visited/visited_dao.dart';
import 'package:places/data/database/visited/visited_table.dart';

part 'database.g.dart';

/// База данных
@UseMoor(
  tables: [SearchHistories, Favorites, Visited, Cache],
  daos: [SearchHistoryDao, FavoritesDao, VisitedDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) {
          return m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from == 1) {
            await m.createTable(favorites);
          }
          if (from == 2) {
            await m.createTable(visited);
          }
          if (from == 3) {
            await m.addColumn(favorites, favorites.sight);
          }
          if (from == 4) {
            await m.addColumn(visited, visited.sight);
          }
          if (from == 5) {
            await m.createTable(cache);
          }
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}
