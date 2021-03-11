import 'dart:io';

import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/sight.dart';
import 'package:places/model/favorites/changes.dart';
import 'package:places/model/visited/changes.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_bottomsheet.dart';
import 'package:places/ui/widgets/ios_date_picker.dart';
import 'package:places/utils/app_ticker_provider.dart';
import 'package:relation/relation.dart';

/// wm для экрана Хочу посетить/Посещенные места
class VisitingWm extends WidgetModel {
  VisitingWm(
    WidgetModelDependencies baseDependencies,
    Model model, {
    this.navigator,
  }) : super(baseDependencies, model: model);

  final NavigatorState navigator;

  final TabController tabController = TabController(
    length: 2,
    vsync: AppTickerProvider(),
  );

  /// список Избранное
  final favoriteSights =
      EntityStreamedState<List<Sight>>(EntityState.loading());

  /// список Посещенные
  final visitedSights = EntityStreamedState<List<Sight>>(EntityState.loading());

  /// Удалить из Избранного
  final removeFromFavorites = Action<Sight>();

  /// Удалить из Посещенных мест
  final removeFromVisited = Action<Sight>();

  /// Показать подробности места
  final showDetails = Action<Sight>();

  /// Выбрать время посещения
  final selectTimeToVisit = Action<Sight>();

  /// тап по табу
  final tabTap = Action<void>();

  @override
  void onBind() {
    super.onBind();
    subscribe(removeFromFavorites.stream, _onRemoveFromFavorites);
    subscribe(showDetails.stream, _onShowDetails);
    subscribe(selectTimeToVisit.stream, _onSelectTimeToVisit);
    subscribe(removeFromVisited.stream, _onRemoveFromVisited);
    subscribe(tabTap.stream, (_) => _onTabTap());
  }

  @override
  void onLoad() {
    super.onLoad();
    _onLoadFavorites();
    _onLoadVisited();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  // Загрузка избранного
  void _onLoadFavorites() {
    favoriteSights.loading();
    doFutureHandleError<List<Sight>>(
      model.perform(GetFavoriteSights()),
      (sights) => favoriteSights.content(sights),
      onError: (e) => favoriteSights.error(e),
    );
  }

  // Загрузка посещенных
  void _onLoadVisited() {
    visitedSights.loading();
    doFutureHandleError<List<Sight>>(
      model.perform(GetVisitedSights()),
      (sights) => visitedSights.content(sights),
      onError: (e) => visitedSights.error(e),
    );
  }

  // Удаление из избранного
  void _onRemoveFromFavorites(Sight sight) {
    model.perform(RemoveFromFavorite(sight));
    _onLoadFavorites();
  }

  // Удаление из посещенных мест
  void _onRemoveFromVisited(Sight sight) {
    model.perform(RemoveFromVisited(sight));
    _onLoadVisited();
  }

  // Показывает подробности места
  Future<void> _onShowDetails(Sight sight) async {
    await showModalBottomSheet(
        context: navigator.context,
        isScrollControlled: true,
        builder: (_) => SightDetailsBottomSheet(sight: sight));
    _onLoadFavorites();
    _onLoadVisited();
  }

  // Выбор времени посещения
  Future<void> _onSelectTimeToVisit(Sight sight) async {
    final first = DateTime.now();
    // на 30 лет вперед
    final last = first.add(const Duration(days: 365 * 30));

    DateTime date;

    if (Platform.isAndroid) {
      date = await showDatePicker(
        context: navigator.context,
        initialDate: first,
        firstDate: first,
        lastDate: last,
      );
    } else if (Platform.isIOS) {
      date = await showIosDatePicker(
        context: navigator.context,
        initialDate: first,
        firstDate: first,
        lastDate: last,
      );
    }

    if (date != null) {
      print('Выбрана дата посещения ${date.toString()}');
    }
  }

  // смена таба
  void _onTabTap() => tabController.animateTo(tabController.index == 0 ? 1 : 0);
}
