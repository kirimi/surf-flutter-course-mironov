import 'package:flutter/cupertino.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/filter_request.dart';
import 'package:places/domain/geo_point.dart';
import 'package:places/domain/sight.dart';
import 'package:places/model/favorites/changes.dart';
import 'package:places/model/repository/favorites_repository.dart';
import 'package:places/model/repository/location_repository.dart';
import 'package:places/model/repository/sight_repository.dart';

/// Добавление места в избранное
class AddToFavoritePerformer extends FuturePerformer<void, AddToFavorite> {
  final FavoritesRepository favoritesRepository;

  AddToFavoritePerformer(this.favoritesRepository);

  @override
  Future<void> perform(AddToFavorite change) =>
      favoritesRepository.add(change.sight.id);
}

/// Удаление места из избранного
class RemoveFromFavoritePerformer
    extends FuturePerformer<void, RemoveFromFavorite> {
  final FavoritesRepository favoritesRepository;

  RemoveFromFavoritePerformer(this.favoritesRepository);

  @override
  Future<void> perform(RemoveFromFavorite change) =>
      favoritesRepository.remove(change.sight.id);
}

/// Получение состояния "избранное" места
class GetFavoriteStatePerformer
    extends FuturePerformer<bool, GetFavoriteState> {
  final FavoritesRepository favoritesRepository;

  GetFavoriteStatePerformer(this.favoritesRepository);

  @override
  Future<bool> perform(GetFavoriteState change) =>
      favoritesRepository.isFavorite(change.sight.id);
}

/// Получение списка мест, отсортированных
/// по удаленности от текущего местоположения
class GetFavoriteSightsPerformer
    extends FuturePerformer<List<Sight>, GetFavoriteSights> {
  final FavoritesRepository favoritesRepository;
  final SightRepository sightRepository;
  final LocationRepository locationRepository;

  GetFavoriteSightsPerformer(
      {@required this.favoritesRepository,
      @required this.sightRepository,
      @required this.locationRepository})
      : assert(favoritesRepository != null),
        assert(sightRepository != null),
        assert(locationRepository != null);

  @override
  Future<List<Sight>> perform(GetFavoriteSights change) =>
      _getFavoritesSights();

  // Отдает список Favorite мест отсортированных по удаленности
  Future<List<Sight>> _getFavoritesSights() async {
    // Получаем id мест добавленных в favorites
    final Set<int> favoritesIds = await favoritesRepository.getList();

    // Получаем список мест с данными по удаленности от текущего местоположения
    // Получаем текущее местоположение
    final GeoPoint currLoc = await locationRepository.getCurrentLocation();
    // радиус поиска максимальный, чтобы захватить все места.
    const double maxRadius = 100000.1;
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

    return sights;
  }
}
