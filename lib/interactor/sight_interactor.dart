import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/filter_request.dart';
import 'package:places/domain/geo_point.dart';
import 'package:places/domain/sight.dart';
import 'package:places/interactor/repository/location_repository.dart';
import 'package:places/interactor/repository/sight_repository.dart';
import 'package:places/interactor/repository/visited_repository.dart';

/// Интерактор Мест
class SightInteractor {
  // это интерфейсы, имплементация в data/,
  final SightRepository sightRepository;
  final LocationRepository locationRepository;
  final VisitedRepository visitedRepository;

  SightInteractor({
    @required this.sightRepository,
    @required this.locationRepository,
    @required this.visitedRepository,
  })  : assert(sightRepository != null),
        assert(locationRepository != null),
        assert(visitedRepository != null);

  /// Получает список мест удовлетворяющих фильтру
  Future<List<Sight>> getFilteredSights({@required Filter filter}) async {
    FilterRequest filterReq;

    // В макете в figma 2 ручки у слайдера. minDistance и maxDistance
    // в api используется одна - radius. todo подумать что сделать с minDistance
    if (filter.maxDistance != null) {
      // Если задан гео-поиск, то получаем текущее местоположение
      // и формируем соответствующий запрос
      final GeoPoint currLoc = await locationRepository.getCurrentLocation();
      filterReq = FilterRequest(
        lat: currLoc.lat,
        lng: currLoc.lon,
        radius: filter.maxDistance,
        typeFilter: filter.types.map((e) => e.code).toList(),
        nameFilter: filter.nameFilter,
      );
    } else {
      filterReq = FilterRequest(
        typeFilter: filter.types.map((e) => e.code).toList(),
        nameFilter: filter.nameFilter,
      );
    }

    final result = await sightRepository.getFilteredList(filterReq);

    final sights = result.map((e) => e.first);

    return sights.toList();
  }

  /// Добавляет новое место
  Future addNewSight(Sight sight) async {
    sightRepository.add(sight);
  }
}
