import 'package:flutter/foundation.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/filter_request.dart';
import 'package:places/domain/geo_point.dart';
import 'package:places/domain/sight.dart';
import 'package:places/model/repository/location_repository.dart';
import 'package:places/model/repository/sight_repository.dart';
import 'package:places/model/sights/changes.dart';

/// Добавление нового места
class AddNewSightPerformer extends FuturePerformer<void, AddNewSight> {
  final SightRepository sightRepository;

  AddNewSightPerformer(this.sightRepository);

  @override
  Future<void> perform(AddNewSight change) {
    return sightRepository.add(change.sight);
  }
}

/// Получение списка мест
class GetSightsPerformer extends FuturePerformer<List<Sight>, GetSights> {
  final SightRepository sightRepository;
  final LocationRepository locationRepository;

  GetSightsPerformer({
    @required this.sightRepository,
    @required this.locationRepository,
  })  : assert(sightRepository != null),
        assert(locationRepository != null);

  @override
  Future<List<Sight>> perform(GetSights change) {
    return _requestFilteredSights(filter: change.filter);
  }

  // Загружает места, которые соответствуют фильтру [filter]
  Future<List<Sight>> _requestFilteredSights({@required Filter filter}) async {
    FilterRequest filterReq;

    if (filter.maxDistance != null) {
      // Если задан гео-поиск, то получаем текущее местоположение
      // и формируем соответствующий запрос
      // final GeoPoint currLoc = await locationRepository.getCurrentLocation();
      final GeoPoint currLoc = await locationRepository.getLastKnownLocation();
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
    return result.map((e) => e.sight).toList();
  }
}
