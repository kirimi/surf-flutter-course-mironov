import 'package:flutter/foundation.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/filter_request.dart';
import 'package:places/domain/geo_point.dart';
import 'package:places/domain/sight.dart';
import 'package:places/interactor/repository/favorites_repository.dart';
import 'package:places/interactor/repository/location_repository.dart';
import 'package:places/interactor/repository/sight_repository.dart';
import 'package:places/interactor/repository/visited_repository.dart';

/// Интерактор Мест
class SightInteractor {
  // это интерфейсы, имплементация в data/,
  final SightRepository placeRepository;
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

    final result = await placeRepository.getFilteredList(filterReq);

    final sights = result.map((e) => e.first);

    return sights.toList();
  }

  /// Добавляет новое место
  Future addNewSight(Sight sight) async {
    placeRepository.add(sight);
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
    final result = await placeRepository.getFilteredList(filterReq);

    // остаются только добавленные в favorites
    final favoritesPlaces = result
        .where((element) => favoritesIds.contains(element.first.id))
        .toList();

    // Сортируем по расстоянию
    favoritesPlaces.sort((a, b) => a.second > b.second ? 1 : -1);

    final sights = favoritesPlaces.map((e) => e.first);

    return sights.toList();
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
    final result = await placeRepository.getFilteredList(const FilterRequest());

    // остаются только добавленные в favorites
    final visitedPlaces = result.where((e) => visitedIds.contains(e.first.id));

    final sights = visitedPlaces.map((e) => e.first);

    return sights.toList();
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
