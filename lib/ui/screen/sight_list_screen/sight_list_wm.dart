import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:places/config.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/sight.dart';
import 'package:places/model/sights/changes.dart';
import 'package:places/ui/screen/add_sight_screen/add_sight_screen.dart';
import 'package:places/ui/screen/filters_screen/filters_screen.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_bottomsheet.dart';
import 'package:places/ui/screen/sight_search_screen/sight_search_screen.dart';
import 'package:relation/relation.dart';

class SightListWm extends WidgetModel {
  SightListWm(
    WidgetModelDependencies baseDependencies,
    Model model,
    this.navigator,
  ) : super(baseDependencies, model: model);

  final NavigatorState navigator;

  /// Места
  final EntityStreamedState<List<Sight>> sights = EntityStreamedState(
    EntityState.loading(),
  );

  /// Фильтр
  final StreamedState<Filter> filter = StreamedState(
    Filter(
      minDistance: Config.minRange,
      maxDistance: Config.maxRange,
      types: [],
    ),
  );

  /// Загрузить места
  final load = Action<void>();

  /// Выбрать фильтр
  final onSelectFilter = Action<void>();

  /// Переход на поиск
  final onSearch = Action<void>();

  /// Переход на добавление нового места
  final onAddSight = Action<void>();

  /// показать подробную информацию
  final showDetails = Action<Sight>();

  @override
  void onBind() {
    super.onBind();
    subscribe(load.stream, (_) => _onLoad());
    subscribe(onSelectFilter.stream, (_) => _onSelectFilter());
    subscribe(onSearch.stream, (_) => _onSearch());
    subscribe(onAddSight.stream, (_) => _onAddSight());
    subscribe(showDetails.stream, _showDetails);
  }

  @override
  void onLoad() {
    super.onLoad();
    _onLoad();
  }

  // Загрузка списка мест с обработчиком ошибок
  Future<void> _onLoad() async {
    sights.loading();
    doFutureHandleError<List<Sight>>(
      model.perform(GetSights(filter.value)),
      (result) => sights.accept(EntityState.content(result)),
      onError: (e) => sights.error(EntityState.error(e)),
    );
  }

  // Пеереход на экран фильтра и обновление списка мест при возврате,
  // если фильтр изменился
  Future<void> _onSelectFilter() async {
    final newFilter = await navigator.pushNamed(
      FiltersScreen.routeName,
      arguments: filter.value,
    ) as Filter;

    if (newFilter != null) {
      filter.accept(newFilter);
      _onLoad();
    }
  }

  // Переход на экран поиска
  void _onSearch() => navigator.pushNamed(
        SightSearchScreen.routeName,
        arguments: filter.value,
      );

  // переход на добавление места и при возврате обновление списка
  Future<void> _onAddSight() async {
    await navigator.pushNamed(AddSightScreen.routeName);
    _onLoad();
  }

  // Показываем боттомшит с подробной информацияй по месту
  void _showDetails(Sight sight) {
    showModalBottomSheet(
        context: navigator.context,
        isScrollControlled: true,
        builder: (_) {
          return SightDetailsBottomSheet(sight: sight);
        });
  }
}
