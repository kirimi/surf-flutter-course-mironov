import 'package:flutter/material.dart' hide Action;
import 'package:map_launcher/map_launcher.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/sight.dart';
import 'package:places/model/favorites/changes.dart';
import 'package:places/model/favorites/performers.dart';
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

  final navigateTo = Action<void>();

  @override
  void onBind() {
    super.onBind();
    subscribe(onBack.stream, (_) => _onBack());
    subscribe(onFavorite.stream, (_) => _onFavorite());
    subscribe(navigateTo.stream, (_) => _onNavigateTo());

    /// Слушаем change и обновляем стейт, если прилетело событие про наш sight
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

  Future<void> _onLoad() async {
    super.onLoad();
    final bool isFav = await model.perform(GetFavoriteState(sight));
    isFavorite.accept(isFav);
  }

  void _onFavorite() => model.perform(ToggleFavorite(sight));

  Future<void> _onNavigateTo() async {
    final availableMaps = await MapLauncher.installedMaps;

    await availableMaps.first.showMarker(
      coords: Coords(sight.point.lat, sight.point.lon),
      title: sight.name,
    );
  }

  void _onBack() => navigator.pop();
}
