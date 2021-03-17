// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class SearchHistory extends DataClass implements Insertable<SearchHistory> {
  final int id;
  final String request;
  SearchHistory({@required this.id, @required this.request});
  factory SearchHistory.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return SearchHistory(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      request:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}request']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || request != null) {
      map['request'] = Variable<String>(request);
    }
    return map;
  }

  SearchHistoriesCompanion toCompanion(bool nullToAbsent) {
    return SearchHistoriesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      request: request == null && nullToAbsent
          ? const Value.absent()
          : Value(request),
    );
  }

  factory SearchHistory.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SearchHistory(
      id: serializer.fromJson<int>(json['id']),
      request: serializer.fromJson<String>(json['request']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'request': serializer.toJson<String>(request),
    };
  }

  SearchHistory copyWith({int id, String request}) => SearchHistory(
        id: id ?? this.id,
        request: request ?? this.request,
      );
  @override
  String toString() {
    return (StringBuffer('SearchHistory(')
          ..write('id: $id, ')
          ..write('request: $request')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, request.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is SearchHistory &&
          other.id == this.id &&
          other.request == this.request);
}

class SearchHistoriesCompanion extends UpdateCompanion<SearchHistory> {
  final Value<int> id;
  final Value<String> request;
  const SearchHistoriesCompanion({
    this.id = const Value.absent(),
    this.request = const Value.absent(),
  });
  SearchHistoriesCompanion.insert({
    this.id = const Value.absent(),
    @required String request,
  }) : request = Value(request);
  static Insertable<SearchHistory> custom({
    Expression<int> id,
    Expression<String> request,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (request != null) 'request': request,
    });
  }

  SearchHistoriesCompanion copyWith({Value<int> id, Value<String> request}) {
    return SearchHistoriesCompanion(
      id: id ?? this.id,
      request: request ?? this.request,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (request.present) {
      map['request'] = Variable<String>(request.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistoriesCompanion(')
          ..write('id: $id, ')
          ..write('request: $request')
          ..write(')'))
        .toString();
  }
}

class $SearchHistoriesTable extends SearchHistories
    with TableInfo<$SearchHistoriesTable, SearchHistory> {
  final GeneratedDatabase _db;
  final String _alias;
  $SearchHistoriesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _requestMeta = const VerificationMeta('request');
  GeneratedTextColumn _request;
  @override
  GeneratedTextColumn get request => _request ??= _constructRequest();
  GeneratedTextColumn _constructRequest() {
    return GeneratedTextColumn(
      'request',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, request];
  @override
  $SearchHistoriesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'search_histories';
  @override
  final String actualTableName = 'search_histories';
  @override
  VerificationContext validateIntegrity(Insertable<SearchHistory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('request')) {
      context.handle(_requestMeta,
          request.isAcceptableOrUnknown(data['request'], _requestMeta));
    } else if (isInserting) {
      context.missing(_requestMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SearchHistory map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return SearchHistory.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $SearchHistoriesTable createAlias(String alias) {
    return $SearchHistoriesTable(_db, alias);
  }
}

class Favorite extends DataClass implements Insertable<Favorite> {
  final int id;
  final int placeId;
  Favorite({@required this.id, @required this.placeId});
  factory Favorite.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return Favorite(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      placeId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}place_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || placeId != null) {
      map['place_id'] = Variable<int>(placeId);
    }
    return map;
  }

  FavoritesCompanion toCompanion(bool nullToAbsent) {
    return FavoritesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      placeId: placeId == null && nullToAbsent
          ? const Value.absent()
          : Value(placeId),
    );
  }

  factory Favorite.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Favorite(
      id: serializer.fromJson<int>(json['id']),
      placeId: serializer.fromJson<int>(json['placeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'placeId': serializer.toJson<int>(placeId),
    };
  }

  Favorite copyWith({int id, int placeId}) => Favorite(
        id: id ?? this.id,
        placeId: placeId ?? this.placeId,
      );
  @override
  String toString() {
    return (StringBuffer('Favorite(')
          ..write('id: $id, ')
          ..write('placeId: $placeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, placeId.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Favorite &&
          other.id == this.id &&
          other.placeId == this.placeId);
}

class FavoritesCompanion extends UpdateCompanion<Favorite> {
  final Value<int> id;
  final Value<int> placeId;
  const FavoritesCompanion({
    this.id = const Value.absent(),
    this.placeId = const Value.absent(),
  });
  FavoritesCompanion.insert({
    this.id = const Value.absent(),
    @required int placeId,
  }) : placeId = Value(placeId);
  static Insertable<Favorite> custom({
    Expression<int> id,
    Expression<int> placeId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (placeId != null) 'place_id': placeId,
    });
  }

  FavoritesCompanion copyWith({Value<int> id, Value<int> placeId}) {
    return FavoritesCompanion(
      id: id ?? this.id,
      placeId: placeId ?? this.placeId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (placeId.present) {
      map['place_id'] = Variable<int>(placeId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesCompanion(')
          ..write('id: $id, ')
          ..write('placeId: $placeId')
          ..write(')'))
        .toString();
  }
}

class $FavoritesTable extends Favorites
    with TableInfo<$FavoritesTable, Favorite> {
  final GeneratedDatabase _db;
  final String _alias;
  $FavoritesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _placeIdMeta = const VerificationMeta('placeId');
  GeneratedIntColumn _placeId;
  @override
  GeneratedIntColumn get placeId => _placeId ??= _constructPlaceId();
  GeneratedIntColumn _constructPlaceId() {
    return GeneratedIntColumn('place_id', $tableName, false,
        $customConstraints: 'type UNIQUE');
  }

  @override
  List<GeneratedColumn> get $columns => [id, placeId];
  @override
  $FavoritesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'favorites';
  @override
  final String actualTableName = 'favorites';
  @override
  VerificationContext validateIntegrity(Insertable<Favorite> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('place_id')) {
      context.handle(_placeIdMeta,
          placeId.isAcceptableOrUnknown(data['place_id'], _placeIdMeta));
    } else if (isInserting) {
      context.missing(_placeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Favorite map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Favorite.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $FavoritesTable createAlias(String alias) {
    return $FavoritesTable(_db, alias);
  }
}

class VisitedData extends DataClass implements Insertable<VisitedData> {
  final int id;
  final int placeId;
  VisitedData({@required this.id, @required this.placeId});
  factory VisitedData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return VisitedData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      placeId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}place_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || placeId != null) {
      map['place_id'] = Variable<int>(placeId);
    }
    return map;
  }

  VisitedCompanion toCompanion(bool nullToAbsent) {
    return VisitedCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      placeId: placeId == null && nullToAbsent
          ? const Value.absent()
          : Value(placeId),
    );
  }

  factory VisitedData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return VisitedData(
      id: serializer.fromJson<int>(json['id']),
      placeId: serializer.fromJson<int>(json['placeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'placeId': serializer.toJson<int>(placeId),
    };
  }

  VisitedData copyWith({int id, int placeId}) => VisitedData(
        id: id ?? this.id,
        placeId: placeId ?? this.placeId,
      );
  @override
  String toString() {
    return (StringBuffer('VisitedData(')
          ..write('id: $id, ')
          ..write('placeId: $placeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, placeId.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is VisitedData &&
          other.id == this.id &&
          other.placeId == this.placeId);
}

class VisitedCompanion extends UpdateCompanion<VisitedData> {
  final Value<int> id;
  final Value<int> placeId;
  const VisitedCompanion({
    this.id = const Value.absent(),
    this.placeId = const Value.absent(),
  });
  VisitedCompanion.insert({
    this.id = const Value.absent(),
    @required int placeId,
  }) : placeId = Value(placeId);
  static Insertable<VisitedData> custom({
    Expression<int> id,
    Expression<int> placeId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (placeId != null) 'place_id': placeId,
    });
  }

  VisitedCompanion copyWith({Value<int> id, Value<int> placeId}) {
    return VisitedCompanion(
      id: id ?? this.id,
      placeId: placeId ?? this.placeId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (placeId.present) {
      map['place_id'] = Variable<int>(placeId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VisitedCompanion(')
          ..write('id: $id, ')
          ..write('placeId: $placeId')
          ..write(')'))
        .toString();
  }
}

class $VisitedTable extends Visited with TableInfo<$VisitedTable, VisitedData> {
  final GeneratedDatabase _db;
  final String _alias;
  $VisitedTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _placeIdMeta = const VerificationMeta('placeId');
  GeneratedIntColumn _placeId;
  @override
  GeneratedIntColumn get placeId => _placeId ??= _constructPlaceId();
  GeneratedIntColumn _constructPlaceId() {
    return GeneratedIntColumn('place_id', $tableName, false,
        $customConstraints: 'type UNIQUE');
  }

  @override
  List<GeneratedColumn> get $columns => [id, placeId];
  @override
  $VisitedTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'visited';
  @override
  final String actualTableName = 'visited';
  @override
  VerificationContext validateIntegrity(Insertable<VisitedData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('place_id')) {
      context.handle(_placeIdMeta,
          placeId.isAcceptableOrUnknown(data['place_id'], _placeIdMeta));
    } else if (isInserting) {
      context.missing(_placeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VisitedData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return VisitedData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $VisitedTable createAlias(String alias) {
    return $VisitedTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $SearchHistoriesTable _searchHistories;
  $SearchHistoriesTable get searchHistories =>
      _searchHistories ??= $SearchHistoriesTable(this);
  $FavoritesTable _favorites;
  $FavoritesTable get favorites => _favorites ??= $FavoritesTable(this);
  $VisitedTable _visited;
  $VisitedTable get visited => _visited ??= $VisitedTable(this);
  SearchHistoryDao _searchHistoryDao;
  SearchHistoryDao get searchHistoryDao =>
      _searchHistoryDao ??= SearchHistoryDao(this as AppDatabase);
  FavoritesDao _favoritesDao;
  FavoritesDao get favoritesDao =>
      _favoritesDao ??= FavoritesDao(this as AppDatabase);
  VisitedDao _visitedDao;
  VisitedDao get visitedDao => _visitedDao ??= VisitedDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [searchHistories, favorites, visited];
}
