import 'dart:math';

import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/sight.dart';
import 'package:places/model/filter/changes.dart';
import 'package:places/model/sights/changes.dart';
import 'package:places/model/theme/changes.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/const.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_bottomsheet.dart';
import 'package:relation/relation.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

/// wm для экрана карты
class MapWm extends WidgetModel {
  MapWm(WidgetModelDependencies baseDependencies, Model model, this.navigator)
      : super(baseDependencies, model: model);

  final NavigatorState navigator;

  YandexMapController _map;

  /// Места, которые отображаются на карте
  final List<Sight> _sights = [];

  /// Выбранное место
  Sight _selectedSight;

  /// Добавленные на карту плейсмарки
  /// сохраняем тут, чтобы можно было их обновить.
  final List<Placemark> _addedPlacemarks = [];

  /// загрузка
  final EntityStreamedState<bool> loading = EntityStreamedState(
    EntityState.loading(),
  );

  /// Выбранное место
  final StreamedState<Sight> selectedSight = StreamedState();

  /// Карта инициализирована
  final initMap = Action<YandexMapController>();

  /// Обновить список мест
  final refresh = Action<void>();

  /// Двинуть карту на пользователя
  final moveToUser = Action<void>();

  /// отменить выделение места
  final cancelSelection = Action<void>();

  /// показать детали места
  final showDetails = Action<Sight>();

  @override
  void onBind() {
    super.onBind();
    subscribe(initMap.stream, _onMapInit);
    subscribe(refresh.stream, (_) => _onRefresh());
    subscribe(moveToUser.stream, (_) => _onMoveToUser());
    subscribe(cancelSelection.stream, (_) => _onCancelSelection());
    subscribe(showDetails.stream, _onShowDetails);
  }

  /// Инициализация
  Future<void> _onMapInit(YandexMapController controller) async {
    _map = controller;

    final isDarkMode = await model.perform(GetDarkMode());
    _map.toggleNightMode(enabled: isDarkMode);

    // Логотип яндекса наверх, чтобы был виден, по правилам mapkit
    _map.logoAlignment(
      horizontal: HorizontalAlignment.right,
      vertical: VerticalAlignment.top,
    );

    // показываем себя
    _map.showUserLayer(
      iconName: Const.imgUserPlacemark,
      arrowName: Const.imgUserPlacemark,
      accuracyCircleFillColor: AppColors.ltAccentColor.withOpacity(.4),
    );

    _onMoveToUser();

    _loadSights();
  }

  /// Обновляет места в соответствии с фидльтром
  void _onRefresh() => _loadSights();

  /// Двигает карту на пользователя
  void _onMoveToUser() => _map.moveToUser();

  /// Клик на место
  void _onSightTap(Sight sight) {
    _selectedSight = sight;

    _updatePlacemarks();

    final sightPoint = Point(
      longitude: sight.point.lon,
      latitude: sight.point.lat,
    );

    _map.move(point: sightPoint);

    selectedSight.accept(sight);
  }

  void _onCancelSelection() {
    _selectedSight = null;
    _updatePlacemarks();
    selectedSight.accept(null);
  }

  // Показываем боттомшит с подробной информацияй по месту
  void _onShowDetails(Sight sight) {
    showModalBottomSheet(
        context: navigator.context,
        isScrollControlled: true,
        builder: (_) {
          return SightDetailsBottomSheet(sight: sight);
        });
  }

  /// Масштабирует карту, чтобы все места влезли на экран
  Future<void> _zoomToSights() async {
    // устанавливаем границы отображаемой карты, чтобы все влезло
    await _map.setBounds(
      southWestPoint: Point(
        latitude: _sights.map((e) => e.point.lat).reduce(min),
        longitude: _sights.map((e) => e.point.lon).reduce(min),
      ),
      northEastPoint: Point(
        latitude: _sights.map((e) => e.point.lat).reduce(max),
        longitude: _sights.map((e) => e.point.lon).reduce(max),
      ),
    );

    // немного zoomOut чтобы места не прилипали к краям экрана
    _map.zoomOut();
  }

  /// Добавляет на карту иконки загруженных мест
  void _updatePlacemarks() {
    _clearPlacemarks();
    for (final sight in _sights) {
      final isSelected = _selectedSight == sight;
      final sightPlacemark = Placemark(
        point: Point(
          longitude: sight.point.lon,
          latitude: sight.point.lat,
        ),
        onTap: (_) => _onSightTap(sight),
        style: PlacemarkStyle(
          opacity: 1,
          iconName: isSelected
              ? Const.imgSelectedSightPlacemark
              : Const.imgSightPlacemark,
        ),
      );
      _map.addPlacemark(sightPlacemark);
      _addedPlacemarks.add(sightPlacemark);
    }
  }

  /// Убирает плейсмарки с карты
  void _clearPlacemarks() {
    for (final placemark in _addedPlacemarks) {
      _map.removePlacemark(placemark);
    }
    _addedPlacemarks.clear();
  }

  /// Загружает места в соответствии с фильтром
  void _loadSights() {
    loading.loading(true);
    final filter = model.perform(GetFilter());
    doFutureHandleError<List<Sight>>(
      model.perform(GetSights(filter)),
      (result) {
        _sights.clear();
        _sights.addAll(result);
        _updatePlacemarks();
        _zoomToSights();
        return loading.accept(EntityState.content(false));
      },
      onError: (e) => loading.error(EntityState.error(e)),
    );
  }
}
