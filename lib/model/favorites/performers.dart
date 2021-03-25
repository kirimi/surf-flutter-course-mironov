import 'package:flutter/cupertino.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/sight.dart';
import 'package:places/model/favorites/changes.dart';
import 'package:places/model/repository/favorites_repository.dart';

/// результат работы ToggleFavoritePerformer
class ToggleFavoriteResult {
  final int sightId;
  final bool isFavorite;

  ToggleFavoriteResult({this.sightId, this.isFavorite});
}

/// Переключение состояния избранного
class ToggleFavoritePerformer
    extends Broadcast<ToggleFavoriteResult, ToggleFavorite> {
  final FavoritesRepository favoritesRepository;

  ToggleFavoritePerformer(this.favoritesRepository);

  @override
  Future<ToggleFavoriteResult> performInternal(ToggleFavorite change) async {
    final bool isFav = await favoritesRepository.isFavorite(change.sight.id);

    if (isFav) {
      favoritesRepository.remove(change.sight.id);
    } else {
      favoritesRepository.add(change.sight);
    }
    return Future.value(
      ToggleFavoriteResult(
        sightId: change.sight.id,
        isFavorite: !isFav,
      ),
    );
  }
}

/// Добавление места в избранное
class AddToFavoritePerformer extends FuturePerformer<void, AddToFavorite> {
  final FavoritesRepository favoritesRepository;

  AddToFavoritePerformer(this.favoritesRepository);

  @override
  Future<void> perform(AddToFavorite change) =>
      favoritesRepository.add(change.sight);
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

  GetFavoriteSightsPerformer({
    @required this.favoritesRepository,
  }) : assert(favoritesRepository != null);

  @override
  Future<List<Sight>> perform(GetFavoriteSights change) =>
      _getFavoritesSights();

  // Отдает список Favorite мест отсортированных по удаленности
  Future<List<Sight>> _getFavoritesSights() async {
    final List<Sight> favorites = await favoritesRepository.getList();
    return favorites;
  }
}
