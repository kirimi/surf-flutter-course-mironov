import 'package:flutter/foundation.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/sight.dart';
import 'package:places/model/favorites/changes.dart';
import 'package:places/model/favorites/performers.dart';
import 'package:relation/relation.dart';

/// wm для кнопки избранного.
class FavoriteButtonWm extends WidgetModel {
  FavoriteButtonWm(
    WidgetModelDependencies baseDependencies,
    Model model, {
    @required this.sight,
  })  : assert(sight != null),
        super(baseDependencies, model: model);

  /// Место
  final Sight sight;

  /// Флаг избранного
  final StreamedState<bool> isFavorite = StreamedState(false);

  /// Тап на кнопке
  final onTap = Action<bool>();

  @override
  void onBind() {
    super.onBind();
    subscribe(onTap.stream, _onTap);

    /// Слушаем ToggleFavorite и обновляем стейт,
    /// если прилетело событие про наш sight
    model.listen<ToggleFavoriteResult, ToggleFavorite>().listen((res) {
      if (res.sightId == sight.id) {
        isFavorite.accept(res.isFavorite);
      }
    });
  }

  @override
  void onLoad() {
    super.onLoad();
    _onLoad();
  }

  // при загрузке получаем начальное значение
  Future<void> _onLoad() async {
    final bool isFav = await model.perform(GetFavoriteState(sight));
    isFavorite.accept(isFav);
  }

  // при тапе на кнопку меняем состояние избранного
  void _onTap(_) => model.perform(ToggleFavorite(sight));
}
