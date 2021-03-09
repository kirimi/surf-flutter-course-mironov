import 'package:mwwm/mwwm.dart';
import 'package:places/domain/sight.dart';
import 'package:places/model/favorites/performers.dart';

/// Переключает состояние Favorite
/// перформер Возвращает ToggleFavoriteResult,
/// в котором есть sight.id и новое состояние Favorite
class ToggleFavorite extends FutureChange<ToggleFavoriteResult> {
  final Sight sight;

  ToggleFavorite(this.sight);
}

/// Добавить место в избранное
class AddToFavorite extends FutureChange<void> {
  final Sight sight;

  AddToFavorite(this.sight);
}

/// Удалить место из избранного
class RemoveFromFavorite extends FutureChange<void> {
  final Sight sight;

  RemoveFromFavorite(this.sight);
}

/// Получить состояния "избранное" места
class GetFavoriteState extends FutureChange<bool> {
  final Sight sight;

  GetFavoriteState(this.sight);
}

/// Получить список избранных мест
class GetFavoriteSights extends FutureChange<List<Sight>> {}
