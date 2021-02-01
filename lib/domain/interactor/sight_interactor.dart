import 'package:flutter/cupertino.dart';
import 'package:places/data/model/filter_request.dart';
import 'package:places/data/model/flitered_place_dto.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/location_repository/location_repository.dart';
import 'package:places/data/repository/place_repository/place_repository.dart';
import 'package:places/domain/mapper/mappers.dart';
import 'package:places/domain/model/filter.dart';
import 'package:places/domain/model/geo_point.dart';
import 'package:places/domain/model/sight.dart';

class SightInteractor {
  final PlaceRepository placeRepository;
  final LocationRepository locationRepository;

  SightInteractor({this.placeRepository, this.locationRepository});

  /// Получает список мест удовлетворяющих фильтру
  Future<List<Sight>> getFilteredSights({@required Filter filter}) async {
    FilterRequest req;

    // В макете в figma 2 ручки у слайдера. minDistance и maxDistance
    // в api используется одна - radius. todo подумать что сделать с minDistance
    if (filter.maxDistance != null) {
      // Если задан гео-поиск, то получаем текущее местоположение
      // и формируем соответствующий запрос
      final GeoPoint currLoc = await locationRepository.getCurrentLocation();
      req = FilterRequest(
        lat: currLoc.lat,
        lng: currLoc.lon,
        radius: filter.maxDistance,
        typeFilter: filter.types.map((e) => e.code).toList(),
        nameFilter: filter.nameFilter,
      );
    } else {
      req = FilterRequest(
        typeFilter: filter.types.map((e) => e.code).toList(),
        nameFilter: filter.nameFilter,
      );
    }

    final places = await placeRepository.getFilteredList(req);

    final sights = places.map((p) {
      // В зависимости от того какой был запрос,
      // приходят разные ответы.
      if (p is FilteredPlaceDto) {
        return SightMapper.fromFilteredPlaceDto(p);
      }
      if (p is PlaceDto) {
        return SightMapper.fromPlaceDto(p);
      }
    }).toList();

    return sights;
  }

  /// Добавляет новое место
  Future addNewSight(Sight sight) async {
    placeRepository.add(PlaceDtoMapper.fromSight(sight));
  }
}
