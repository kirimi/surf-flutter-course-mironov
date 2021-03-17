import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:places/data/database/favorites/favorites_dao.dart';
import 'package:places/data/database/favorites/favorites_table.dart';
import 'package:places/data/database/search_history/search_history_table.dart';
import 'package:places/data/database/search_history/search_history_dao.dart';

part 'database.g.dart';

/// База данных
@UseMoor(
  tables: [SearchHistories, Favorites],
  daos: [SearchHistoryDao, FavoritesDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) {
          return m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from == 1) {
            await m.createTable(favorites);
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
