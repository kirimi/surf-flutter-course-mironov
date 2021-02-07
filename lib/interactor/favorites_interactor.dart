import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:places/domain/filter_request.dart';
import 'package:places/domain/geo_point.dart';
import 'package:places/domain/sight.dart';
import 'package:places/interactor/repository/favorites_repository.dart';
import 'package:places/interactor/repository/location_repository.dart';
import 'package:places/interactor/repository/sight_repository.dart';

/// Интерактор мест в закладках Favorites
class FavoritesInteractor {
  final FavoritesRepository favoritesRepository;
  final LocationRepository locationRepository;
  final SightRepository sightRepository;

  final StreamController<List<Sight>> _favoritesStreamController =
      StreamController.broadcast();
  Stream<List<Sight>> get favoritesStream => _favoritesStreamController.stream;

  FavoritesInteractor({
    @required this.sightRepository,
    @required this.favoritesRepository,
    @required this.locationRepository,
  })  : assert(sightRepository != null),
        assert(favoritesRepository != null),
        assert(locationRepository != null);

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
    final result = await sightRepository.getFilteredList(filterReq);

    // остаются только добавленные в favorites
    final favoritesPlaces = result
        .where((element) => favoritesIds.contains(element.first.id))
        .toList();

    // Сортируем по расстоянию
    favoritesPlaces.sort((a, b) => a.second > b.second ? 1 : -1);

    final sights = favoritesPlaces.map((e) => e.first).toList();

    _favoritesStreamController.sink.add(sights);

    return sights;
  }

  /// Добавляет место в Favorites
  Future<void> addToFavorites(Sight sight) async {
    await favoritesRepository.add(sight.id);
    getFavoritesSights();
  }

  /// Удаляет место из Favorites
  Future<void> removeFromFavorites(Sight sight) async {
    await favoritesRepository.remove(sight.id);
    getFavoritesSights();
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
}
