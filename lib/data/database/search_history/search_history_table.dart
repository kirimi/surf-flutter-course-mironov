import 'package:moor/moor.dart';

/// Таблица для хранения истории поиска в moor
@DataClassName('SearchHistory')
class SearchHistories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get request => text()();
}
