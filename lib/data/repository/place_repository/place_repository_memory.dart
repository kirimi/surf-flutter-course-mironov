import 'dart:math';

import 'package:places/data/model/filter_request.dart';
import 'package:places/data/model/flitered_place_dto.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/place_repository/place_repository.dart';
import 'package:places/domain/model/geo_point.dart';

/// Репозиторий мест. Данные в памяти. Для тестов
///
/// примерно так будет выглядеть репозиторий с данными в db
class PlaceRepositoryMemory implements PlaceRepository {
  final List<PlaceDto> _places = [];

  // текущий индекс autoincrement
  int _currentId = 0;

  @override
  Future<PlaceDto> add(PlaceDto place) async {
    final newPlace = place.copyWith(id: _currentId);
    _places.add(newPlace);
    _currentId++;
    print(_places);
    return Future.value(newPlace);
  }

  @override
  Future<void> delete({int id}) async {
    _places.removeWhere((element) => element.id == id);
  }

  @override
  Future<PlaceDto> get({int id}) async {
    final place = _places.singleWhere(
      (element) => element.id == id,
      orElse: () => null,
    );
    return place != null ? Future.value(place) : Future.error('Not found');
  }

  @override
  Future<List> getFilteredList(FilterRequest filter) async {
    final filteredByNameAndType = _places.where((p) {
      // отфильтровываем по типу места
      return filter.typeFilter == null ||
          filter.typeFilter.isEmpty ||
          filter.typeFilter.contains(p.placeType);
    }).where((p) {
      // отфильтровываем по имени
      return filter.nameFilter == null ||
          filter.nameFilter == '' ||
          p.name
              .trim()
              .toLowerCase()
              .contains(filter.nameFilter.trim().toLowerCase());
    }).toList();

    if (filter.radius == null || filter.lat == null || filter.lng == null) {
      // Если запрос был без фильтра по координате
      return Future.value(filteredByNameAndType);
    } else {
      // Если запрос был с фильтром по координате, то делаем фильтрацию

      final filteredByDist = filteredByNameAndType.where((p) {
        // Отфильтровываем по расстоянию
        final dist = _getDistance(
          point: GeoPoint(lat: p.lat, lon: p.lng),
          center: GeoPoint(lat: filter.lat, lon: filter.lng),
        );
        return dist < filter.radius;
      }).map((p) {
        // мапим в FilteredPlaceDto
        final dist = _getDistance(
          point: GeoPoint(lat: p.lat, lon: p.lng),
          center: GeoPoint(lat: filter.lat, lon: filter.lng),
        );
        return FilteredPlaceDto(
          id: p.id,
          name: p.name,
          lat: p.lat,
          lng: p.lng,
          urls: p.urls,
          description: p.description,
          placeType: p.placeType,
          distance: dist,
        );
      }).toList();
      return Future.value(filteredByDist);
    }
  }

  @override
  Future<List<PlaceDto>> getList({int count, int offset}) async {
    List<PlaceDto> slice = [];
    int start, end;

    // Если начальная позиция за пределами списка, то возвращаем пустой список
    if (offset > 0 || offset < _places.length) {
      start = offset;
    } else {
      return Future.value(slice);
    }

    // Если запрошено больше элементов, чем есть, то возвращаем то что осталось
    if (offset + count < _places.length) {
      end = offset + count;
    } else {
      end = _places.length;
    }

    slice = _places.sublist(start, end);
    return Future.value(slice);
  }

  @override
  Future<PlaceDto> update(PlaceDto place) async {
    final index = _places.indexWhere((element) => element.id == place.id);
    if (index == -1) {
      return Future.error('Not found');
    }
    _places[index] = place;
    return Future.value(place);
  }

  /// Возвращает расстояние между [point] и [center] в метрах.
  double _getDistance({
    GeoPoint point,
    GeoPoint center,
  }) {
    const double ky = 40000000 / 360;
    final double kx = cos(pi * point.lat / 180.0) * ky;
    final double dx = (point.lon - center.lon).abs() * kx;
    final double dy = (point.lat - center.lat).abs() * ky;
    final double dis = sqrt(dx * dx + dy * dy);
    return dis;
  }
}
