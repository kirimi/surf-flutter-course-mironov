import 'package:moor/moor.dart';

/// Таблица для хранения списка избранного
class Favorites extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get placeId => integer().customConstraint('type UNIQUE')();
  TextColumn get sight => text()();
}
