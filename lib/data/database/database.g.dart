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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $SearchHistoriesTable _searchHistories;
  $SearchHistoriesTable get searchHistories =>
      _searchHistories ??= $SearchHistoriesTable(this);
  SearchHistoryDao _searchHistoryDao;
  SearchHistoryDao get searchHistoryDao =>
      _searchHistoryDao ??= SearchHistoryDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [searchHistories];
}
