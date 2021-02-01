import 'package:flutter/foundation.dart';
import 'package:places/data/model/filter_request.dart';
import 'package:places/data/model/flitered_place_dto.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/favorites_repository/favorites_repository.dart';
import 'package:places/data/repository/location_repository/location_repository.dart';
import 'package:places/data/repository/place_repository/place_repository.dart';
import 'package:places/data/repository/visited_repository/visited_repository.dart';
import 'package:places/domain/mapper/mappers.dart';
import 'package:places/domain/model/filter.dart';
import 'package:places/domain/model/geo_point.dart';
import 'package:places/domain/model/sight.dart';

/// Интерактор Мест
class SightInteractor {
  final PlaceRepository placeRepository;
  final LocationRepository locationRepository;
  final FavoritesRepository favoritesRepository;
  final VisitedRepository visitedRepository;

  SightInteractor({
    @required this.placeRepository,
    @required this.locationRepository,
    @required this.favoritesRepository,
    @required this.visitedRepository,
  })  : assert(placeRepository != null),
        assert(locationRepository != null),
        assert(favoritesRepository != null),
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

    final places = await placeRepository.getFilteredList(filterReq);

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

  /// Получает список Favorite мест отсортированных по удаленности
  Future<List<Sight>> getFavoritesSights() async {
    // Получаем id мест добавленных в favorites
    final Set<int> favoritesIds = await favoritesRepository.getList();

    // Получаем список мест с данными по удаленности от текущего местоположения

    // в api не хватает параметра фильтра типа "список id".
    // Так можно было бы запросить у сервера только нужные объекты. А так получается,
    // что запрашиваем все, сервер снабжает это полем distance,
    // по которому локально сортируем.
    // Другой вариант сделать множество запросов используя GET /place/id и
    // рассчитать локально distance для каждого.
    // Остановился до выяснения на первом варианте )

    // Получаем текущее местоположение
    final GeoPoint currLoc = await locationRepository.getCurrentLocation();
    // радиус поиска максимальный, чтобы захватить все места.
    const double maxRadius = 1000000000;
    final FilterRequest filterReq = FilterRequest(
      lng: currLoc.lon,
      lat: currLoc.lat,
      radius: maxRadius,
    );

    // получаем все места
    final allPlaces = await placeRepository.getFilteredList(filterReq)
        as List<FilteredPlaceDto>;

    // остаются только добавленные в favorites
    final favoritesPlaces = allPlaces
        .where((element) => favoritesIds.contains(element.id))
        .toList();

    // Сортируем по расстоянию
    favoritesPlaces.sort((a, b) => a.distance > b.distance ? 1 : -1);

    // Мапим в List<Sight>
    final sights = favoritesPlaces
        .map((p) => SightMapper.fromFilteredPlaceDto(p))
        .toList();

    return sights;
  }

  /// Добавляет место в Favorites
  Future<void> addToFavorites(Sight sight) async {
    await favoritesRepository.add(sight.id);
  }

  /// Удаляет место из Favorites
  Future<void> removeFromFavorites(Sight sight) async {
    await favoritesRepository.remove(sight.id);
  }

  /// Возвращает включена ли место в Favorites
  Future<bool> isFavorite(Sight sight) async {
    final bool isFav = await favoritesRepository.isFavorite(sight.id);
    return isFav;
  }

  /// Переключает место в Favorites и обратно
  Future<void> switchFavorite(Sight sight) async {
    final bool isFav = await favoritesRepository.isFavorite(sight.id);
    if (isFav) {
      removeFromFavorites(sight);
    } else {
      addToFavorites(sight);
    }
  }

  /// Получает список Favorite мест отсортированных по удаленности
  Future<List<Sight>> getVisitedSights() async {
    // Получаем id мест добавленных в visited
    final Set<int> visitedIds = await visitedRepository.getList();

    // в api не хватает параметра фильтра типа "список id".
    // получаем все места
    final allPlaces = await placeRepository
        .getFilteredList(const FilterRequest()) as List<PlaceDto>;

    // остаются только добавленные в favorites
    final visitedPlaces =
        allPlaces.where((element) => visitedIds.contains(element.id)).toList();

    // Мапим в List<Sight>
    final sights =
        visitedPlaces.map((p) => SightMapper.fromPlaceDto(p)).toList();

    return sights;
  }

  /// Добавляет место в Visited
  Future<void> addToVisited(Sight sight) async {
    await visitedRepository.add(sight.id);
  }

  /// Удаляет место из Visited
  Future<void> removeFromVisited(Sight sight) async {
    await visitedRepository.remove(sight.id);
  }
}
