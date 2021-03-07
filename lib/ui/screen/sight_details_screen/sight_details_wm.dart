import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/sight.dart';
import 'package:places/model/favorites/changes.dart';
import 'package:relation/relation.dart';

/// wm для SightDetailsBottomSheet
class SightDetailsWm extends WidgetModel {
  SightDetailsWm(
    WidgetModelDependencies baseDependencies,
    Model model,
    this.navigator, {
    @required this.sight,
  })  : assert(sight != null),
        super(baseDependencies, model: model);

  final NavigatorState navigator;

  final Sight sight;

  final StreamedState<bool> isFavorite = StreamedState(false);

  /// Переход назад
  final onBack = Action<void>();

  /// Нажата кнопка Favorite
  final onFavorite = Action<void>();

  @override
  void onBind() {
    super.onBind();
    subscribe(onBack.stream, (_) => _onBack());
    subscribe(onFavorite.stream, (_) => _onFavorite());
  }

  @override
  void onLoad() {
    super.onLoad();
    _onLoad();
  }

  Future<void> _onLoad() async {
    super.onLoad();
    final bool isFav = await model.perform(GetFavoriteState(sight));
    isFavorite.accept(isFav);
  }

  void _onFavorite() {
    if (isFavorite.value) {
      model.perform(RemoveFromFavorite(sight));
    } else {
      model.perform(AddToFavorite(sight));
    }
    isFavorite.accept(!isFavorite.value);
  }

  void _onBack() => navigator.pop();
}
