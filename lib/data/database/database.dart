import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:places/data/database/search_history/search_history.dart';
import 'package:places/data/database/search_history/search_history_dao.dart';

part 'database.g.dart';

/// База данных
@UseMoor(
  tables: [SearchHistories],
  daos: [SearchHistoryDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}
