import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/geo_point.dart';
import 'package:places/model/location/changes.dart';
import 'package:places/model/theme/changes.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/const.dart';
import 'package:places/utils/utils.dart';
import 'package:relation/relation.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

/// wm для экрана выбора геопозиции
class SelectLocationWm extends WidgetModel {
  SelectLocationWm(
      WidgetModelDependencies baseDependencies, Model model, this.navigator)
      : super(baseDependencies, model: model);

  final NavigatorState navigator;

  YandexMapController _map;

  /// Карта инициализирована
  final initMap = Action<YandexMapController>();

  /// Кнопка назад
  final back = Action<void>();

  /// Локация выбрана
  final submit = Action<void>();

  @override
  void onBind() {
    super.onBind();
    subscribe(initMap.stream, _onMapInit);
    subscribe(submit.stream, _onSubmit);
    subscribe(back.stream, _onBack);
  }

  /// Инициализация
  Future<void> _onMapInit(YandexMapController controller) async {
    _map = controller;

    final isDarkMode = await model.perform(GetDarkMode());
    _map.toggleNightMode(enabled: isDarkMode);

    // показываем себя
    _map.showUserLayer(
      iconName: Const.imgUserPlacemark,
      arrowName: Const.imgUserPlacemark,
      accuracyCircleFillColor: AppColors.ltAccentColor.withOpacity(.4),
    );

    // двигаем карту на текущее местоположении
    final currentLocation = await model.perform(GetLastKnownLocation());
    _map.move(
      point: Point(
        latitude: currentLocation.lat,
        longitude: currentLocation.lon,
      ),
    );

    // показываем мишень на карте
    _map.enableCameraTracking(
      const PlacemarkStyle(
        opacity: 1,
        scale: 3.0,
        iconName: Const.imgTarget,
      ),
      (msg) {},
    );
  }

  /// Возврат назад с результатом
  Future<void> _onSubmit(_) async {
    final point = await _map.getTargetPoint();
    navigator.pop(
      GeoPoint(
        lon: roundDouble(point.longitude, 5),
        lat: roundDouble(point.latitude, 5),
      ),
    );
  }

  /// Возврат назад
  void _onBack(_) => navigator.pop();
}
