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
  final String sight;
  Favorite({@required this.id, @required this.placeId, @required this.sight});
  factory Favorite.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Favorite(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      placeId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}place_id']),
      sight:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}sight']),
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
    if (!nullToAbsent || sight != null) {
      map['sight'] = Variable<String>(sight);
    }
    return map;
  }

  FavoritesCompanion toCompanion(bool nullToAbsent) {
    return FavoritesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      placeId: placeId == null && nullToAbsent
          ? const Value.absent()
          : Value(placeId),
      sight:
          sight == null && nullToAbsent ? const Value.absent() : Value(sight),
    );
  }

  factory Favorite.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Favorite(
      id: serializer.fromJson<int>(json['id']),
      placeId: serializer.fromJson<int>(json['placeId']),
      sight: serializer.fromJson<String>(json['sight']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'placeId': serializer.toJson<int>(placeId),
      'sight': serializer.toJson<String>(sight),
    };
  }

  Favorite copyWith({int id, int placeId, String sight}) => Favorite(
        id: id ?? this.id,
        placeId: placeId ?? this.placeId,
        sight: sight ?? this.sight,
      );
  @override
  String toString() {
    return (StringBuffer('Favorite(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('sight: $sight')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(placeId.hashCode, sight.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Favorite &&
          other.id == this.id &&
          other.placeId == this.placeId &&
          other.sight == this.sight);
}

class FavoritesCompanion extends UpdateCompanion<Favorite> {
  final Value<int> id;
  final Value<int> placeId;
  final Value<String> sight;
  const FavoritesCompanion({
    this.id = const Value.absent(),
    this.placeId = const Value.absent(),
    this.sight = const Value.absent(),
  });
  FavoritesCompanion.insert({
    this.id = const Value.absent(),
    @required int placeId,
    @required String sight,
  })  : placeId = Value(placeId),
        sight = Value(sight);
  static Insertable<Favorite> custom({
    Expression<int> id,
    Expression<int> placeId,
    Expression<String> sight,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (placeId != null) 'place_id': placeId,
      if (sight != null) 'sight': sight,
    });
  }

  FavoritesCompanion copyWith(
      {Value<int> id, Value<int> placeId, Value<String> sight}) {
    return FavoritesCompanion(
      id: id ?? this.id,
      placeId: placeId ?? this.placeId,
      sight: sight ?? this.sight,
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
    if (sight.present) {
      map['sight'] = Variable<String>(sight.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesCompanion(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('sight: $sight')
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

  final VerificationMeta _sightMeta = const VerificationMeta('sight');
  GeneratedTextColumn _sight;
  @override
  GeneratedTextColumn get sight => _sight ??= _constructSight();
  GeneratedTextColumn _constructSight() {
    return GeneratedTextColumn(
      'sight',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, placeId, sight];
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
    if (data.containsKey('sight')) {
      context.handle(
          _sightMeta, sight.isAcceptableOrUnknown(data['sight'], _sightMeta));
    } else if (isInserting) {
      context.missing(_sightMeta);
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
  final String sight;
  VisitedData(
      {@required this.id, @required this.placeId, @required this.sight});
  factory VisitedData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return VisitedData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      placeId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}place_id']),
      sight:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}sight']),
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
    if (!nullToAbsent || sight != null) {
      map['sight'] = Variable<String>(sight);
    }
    return map;
  }

  VisitedCompanion toCompanion(bool nullToAbsent) {
    return VisitedCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      placeId: placeId == null && nullToAbsent
          ? const Value.absent()
          : Value(placeId),
      sight:
          sight == null && nullToAbsent ? const Value.absent() : Value(sight),
    );
  }

  factory VisitedData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return VisitedData(
      id: serializer.fromJson<int>(json['id']),
      placeId: serializer.fromJson<int>(json['placeId']),
      sight: serializer.fromJson<String>(json['sight']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'placeId': serializer.toJson<int>(placeId),
      'sight': serializer.toJson<String>(sight),
    };
  }

  VisitedData copyWith({int id, int placeId, String sight}) => VisitedData(
        id: id ?? this.id,
        placeId: placeId ?? this.placeId,
        sight: sight ?? this.sight,
      );
  @override
  String toString() {
    return (StringBuffer('VisitedData(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('sight: $sight')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(placeId.hashCode, sight.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is VisitedData &&
          other.id == this.id &&
          other.placeId == this.placeId &&
          other.sight == this.sight);
}

class VisitedCompanion extends UpdateCompanion<VisitedData> {
  final Value<int> id;
  final Value<int> placeId;
  final Value<String> sight;
  const VisitedCompanion({
    this.id = const Value.absent(),
    this.placeId = const Value.absent(),
    this.sight = const Value.absent(),
  });
  VisitedCompanion.insert({
    this.id = const Value.absent(),
    @required int placeId,
    @required String sight,
  })  : placeId = Value(placeId),
        sight = Value(sight);
  static Insertable<VisitedData> custom({
    Expression<int> id,
    Expression<int> placeId,
    Expression<String> sight,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (placeId != null) 'place_id': placeId,
      if (sight != null) 'sight': sight,
    });
  }

  VisitedCompanion copyWith(
      {Value<int> id, Value<int> placeId, Value<String> sight}) {
    return VisitedCompanion(
      id: id ?? this.id,
      placeId: placeId ?? this.placeId,
      sight: sight ?? this.sight,
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
    if (sight.present) {
      map['sight'] = Variable<String>(sight.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VisitedCompanion(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('sight: $sight')
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

  final VerificationMeta _sightMeta = const VerificationMeta('sight');
  GeneratedTextColumn _sight;
  @override
  GeneratedTextColumn get sight => _sight ??= _constructSight();
  GeneratedTextColumn _constructSight() {
    return GeneratedTextColumn(
      'sight',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, placeId, sight];
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
    if (data.containsKey('sight')) {
      context.handle(
          _sightMeta, sight.isAcceptableOrUnknown(data['sight'], _sightMeta));
    } else if (isInserting) {
      context.missing(_sightMeta);
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

class CacheData extends DataClass implements Insertable<CacheData> {
  final int id;
  final int created;
  final String key;
  final String value;
  CacheData(
      {@required this.id,
      @required this.created,
      @required this.key,
      @required this.value});
  factory CacheData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return CacheData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      created:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}created']),
      key: stringType.mapFromDatabaseResponse(data['${effectivePrefix}key']),
      value:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}value']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || created != null) {
      map['created'] = Variable<int>(created);
    }
    if (!nullToAbsent || key != null) {
      map['key'] = Variable<String>(key);
    }
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    return map;
  }

  CacheCompanion toCompanion(bool nullToAbsent) {
    return CacheCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      created: created == null && nullToAbsent
          ? const Value.absent()
          : Value(created),
      key: key == null && nullToAbsent ? const Value.absent() : Value(key),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
    );
  }

  factory CacheData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return CacheData(
      id: serializer.fromJson<int>(json['id']),
      created: serializer.fromJson<int>(json['created']),
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'created': serializer.toJson<int>(created),
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  CacheData copyWith({int id, int created, String key, String value}) =>
      CacheData(
        id: id ?? this.id,
        created: created ?? this.created,
        key: key ?? this.key,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('CacheData(')
          ..write('id: $id, ')
          ..write('created: $created, ')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(created.hashCode, $mrjc(key.hashCode, value.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is CacheData &&
          other.id == this.id &&
          other.created == this.created &&
          other.key == this.key &&
          other.value == this.value);
}

class CacheCompanion extends UpdateCompanion<CacheData> {
  final Value<int> id;
  final Value<int> created;
  final Value<String> key;
  final Value<String> value;
  const CacheCompanion({
    this.id = const Value.absent(),
    this.created = const Value.absent(),
    this.key = const Value.absent(),
    this.value = const Value.absent(),
  });
  CacheCompanion.insert({
    this.id = const Value.absent(),
    @required int created,
    @required String key,
    @required String value,
  })  : created = Value(created),
        key = Value(key),
        value = Value(value);
  static Insertable<CacheData> custom({
    Expression<int> id,
    Expression<int> created,
    Expression<String> key,
    Expression<String> value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (created != null) 'created': created,
      if (key != null) 'key': key,
      if (value != null) 'value': value,
    });
  }

  CacheCompanion copyWith(
      {Value<int> id,
      Value<int> created,
      Value<String> key,
      Value<String> value}) {
    return CacheCompanion(
      id: id ?? this.id,
      created: created ?? this.created,
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (created.present) {
      map['created'] = Variable<int>(created.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CacheCompanion(')
          ..write('id: $id, ')
          ..write('created: $created, ')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $CacheTable extends Cache with TableInfo<$CacheTable, CacheData> {
  final GeneratedDatabase _db;
  final String _alias;
  $CacheTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _createdMeta = const VerificationMeta('created');
  GeneratedIntColumn _created;
  @override
  GeneratedIntColumn get created => _created ??= _constructCreated();
  GeneratedIntColumn _constructCreated() {
    return GeneratedIntColumn(
      'created',
      $tableName,
      false,
    );
  }

  final VerificationMeta _keyMeta = const VerificationMeta('key');
  GeneratedTextColumn _key;
  @override
  GeneratedTextColumn get key => _key ??= _constructKey();
  GeneratedTextColumn _constructKey() {
    return GeneratedTextColumn(
      'key',
      $tableName,
      false,
    );
  }

  final VerificationMeta _valueMeta = const VerificationMeta('value');
  GeneratedTextColumn _value;
  @override
  GeneratedTextColumn get value => _value ??= _constructValue();
  GeneratedTextColumn _constructValue() {
    return GeneratedTextColumn(
      'value',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, created, key, value];
  @override
  $CacheTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'cache';
  @override
  final String actualTableName = 'cache';
  @override
  VerificationContext validateIntegrity(Insertable<CacheData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created'], _createdMeta));
    } else if (isInserting) {
      context.missing(_createdMeta);
    }
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key'], _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value'], _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CacheData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return CacheData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $CacheTable createAlias(String alias) {
    return $CacheTable(_db, alias);
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
  $CacheTable _cache;
  $CacheTable get cache => _cache ??= $CacheTable(this);
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
      [searchHistories, favorites, visited, cache];
}
