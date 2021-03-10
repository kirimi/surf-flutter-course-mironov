import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:places/config.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/sight_type/default_sight_types.dart';
import 'package:places/domain/sight_type/sight_type.dart';
import 'package:places/model/sights/changes.dart';
import 'package:relation/relation.dart';

/// wm для экрана фильтров
class FiltersWm extends WidgetModel {
  FiltersWm(
    WidgetModelDependencies baseDependencies,
    Model model, {
    this.navigator,
    this.filter,
  }) : super(baseDependencies, model: model);

  final NavigatorState navigator;

  /// Фильтр
  final Filter filter;

  /// список категорий
  final List<SightType> sightTypes = defaultSightTypes;

  /// выбранные категории
  final selectedSightTypes = StreamedState<List<SightType>>([]);

  /// Значения фильтра по расстоянию, для слайдера
  final rangeValues = StreamedState<RangeValues>();

  /// количество элементов, которые попадают под условие фильтра
  final filteredCount = StreamedState<int>(0);

  /// Очистить фильтр
  final clearFilter = Action<void>();

  /// Слайдер переместился
  final onChangeRange = Action<RangeValues>();

  /// Пользователь закончил перемещать слайдер
  final onFinishChangeRange = Action<RangeValues>();

  /// Тап на категории
  final toggleSightType = Action<SightType>();

  /// кпопка показать
  final onShow = Action<void>();

  @override
  void onLoad() {
    super.onLoad();
    rangeValues.accept(RangeValues(filter.minDistance, filter.maxDistance));
    selectedSightTypes.accept(filter.types);
    _updateCount();
  }

  @override
  void onBind() {
    super.onBind();
    subscribe(clearFilter.stream, (_) => _onClearFilter());
    subscribe(onFinishChangeRange.stream, _onFinishRangeChange);
    subscribe(onChangeRange.stream, _onChangeRange);
    subscribe(toggleSightType.stream, _onToggleSightType);
    subscribe(onShow.stream, (_) => _onShow());
  }

  // при изменении слайдера
  void _onChangeRange(RangeValues newRangeValues) {
    rangeValues.accept(newRangeValues);
  }

  // пользователь закончил перетягивать слайдер
  Future<void> _onFinishRangeChange(RangeValues newRangeValues) async {
    filter.minDistance = newRangeValues.start;
    filter.maxDistance = newRangeValues.end;
    _updateCount();
  }

  // сбрасывает фильтры в начальное значение
  void _onClearFilter() {
    filter.minDistance = Config.minRange;
    filter.maxDistance = Config.maxRange;
    filter.types.clear();
    rangeValues.accept(RangeValues(filter.minDistance, filter.maxDistance));
    selectedSightTypes.accept(filter.types);
    _updateCount();
  }

  // При тапе на категорию добавляем или убираем ее в фильтре
  void _onToggleSightType(SightType sightType) {
    filter.types.contains(sightType)
        ? filter.types.remove(sightType)
        : filter.types.add(sightType);
    selectedSightTypes.accept(filter.types);
    _updateCount();
  }

  // количество точек, которые попадают под условие фильтра
  Future<void> _updateCount() async {
    final count = (await model.perform(GetSights(filter))).length;
    filteredCount.accept(count);
  }

  // по кнопке показать переходим назад и возвращаем фильтр
  void _onShow() => navigator.pop(filter);
}
