import 'package:moor/moor.dart';

/// Таблица для элемента кеша
class Cache extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get created => integer()();
  TextColumn get key => text()();
  TextColumn get value => text()();
}
