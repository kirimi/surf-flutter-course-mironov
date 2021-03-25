import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:places/data/cache_repository/cache_repository.dart';
import 'package:places/domain/filter_request.dart';
import 'package:places/domain/sight.dart';
import 'package:places/domain/sight_with_distance.dart';
import 'package:places/model/repository/sight_repository.dart';
import 'package:places/utils/utils.dart';

/// Репозиторий мест.
///
/// Данные при запросе в network кешируются в db.
class SightRepositoryCached implements SightRepository {
  final SightRepository network;
  final CacheRepository cache;

  SightRepositoryCached({
    @required this.network,
    @required this.cache,
  })  : assert(network != null),
        assert(cache != null);

  @override
  Future<Sight> add(Sight place) => network.add(place);

  @override
  Future<void> delete({int id}) => network.delete(id: id);

  @override
  Future<Sight> get({int id}) => network.get(id: id);

  @override
  Future<Sight> update(Sight sight) => network.update(sight);

  /// Загружает места. Использует кеш.
  /// Если force = true, то делает запрос мимо кеша.
  @override
  Future<List<SightWithDistance>> getFilteredList(
    FilterRequest filter, {
    bool force = false,
  }) async {
    if (!force) {
      // пробуем из кеша
      try {
        final cachedData = await cache.get(_getCacheKey(filter));
        final json = jsonDecode(cachedData) as List<dynamic>;

        final result = json
            .map((e) => SightWithDistance.fromJson(e as Map<String, dynamic>))
            .toList();

        return result;
      } catch (_) {}
    }

    final response = await network.getFilteredList(filter);
    cache.add(_getCacheKey(filter), jsonEncode(response));
    return response;
  }

  @override
  Future<List<Sight>> getList({int count, int offset}) {
    throw UnimplementedError();
  }

  /// Ключ для сохранения в кеше
  String _getCacheKey(FilterRequest filterRequest) {
    // Округляем координаты до 2 знаков, чтобы прыгающий gps не давал помехи.
    final flt = filterRequest.copyWith(
      lat: roundDouble(filterRequest.lat, 2),
      lng: roundDouble(filterRequest.lng, 2),
    );

    final request = jsonEncode(flt.toJson());
    return request.hashCode.toString();
  }
}
