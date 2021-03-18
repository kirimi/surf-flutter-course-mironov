import 'package:moor/moor.dart';

/// Таблица для хранения списка посещенных мест
class Visited extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get placeId => integer().customConstraint('type UNIQUE')();
}
