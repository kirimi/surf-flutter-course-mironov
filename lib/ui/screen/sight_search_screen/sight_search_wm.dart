import 'dart:async';

import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/sight.dart';
import 'package:places/model/search_history/changes.dart';
import 'package:places/model/sights/changes.dart';
import 'package:relation/relation.dart';

/// Запрос для поиска
/// [term] - строка для поиска
/// [performNow] - true, если запрос надо выполнить сразу
class SearchRequest {
  final String term;
  final bool performNow;

  SearchRequest(this.term, {this.performNow = false});
}

/// wm для страницы поиска
class SightSearchWm extends WidgetModel {
  SightSearchWm(
    WidgetModelDependencies baseDependencies,
    Model model, {
    @required this.navigator,
    @required this.filter,
  })  : assert(navigator != null),
        assert(filter != null),
        super(baseDependencies, model: model);

  final NavigatorState navigator;

  /// Фильтр, по которому производится поиск
  final Filter filter;

  /// Поле ввода поиска
  final TextEditingAction searchText = TextEditingAction();

  /// Результаты поиска
  final searchResult = EntityStreamedState<List<Sight>>();

  /// Показывать ли историю
  final historyShow = StreamedState<bool>(true);

  /// Выполнить поиск
  final search = Action<SearchRequest>();

  /// Очистить запрос поиска
  final clearSearch = Action<void>();

  /// Переход назад
  final onBack = Action<void>();

  // Подписка для отмены текущего запроса
  StreamSubscription<List> _loading;
  // Таймер для паузы между запросом и вводом пользователя.
  Timer _debounceTimer;

  @override
  void onBind() {
    super.onBind();
    subscribe(search.stream, _onSearch);
    subscribe(clearSearch.stream, (_) => _onClearSearch());
    subscribe(onBack.stream, (_) => _onBack());
  }

  Future<void> _onSearch(SearchRequest searchRequest) async {
    historyShow.accept(false);

    _debounceTimer?.cancel();
    if (searchRequest.term != '') {
      // делаем запрос только через секунду после последнего ввода пользователя
      final int time = searchRequest.performNow ? 0 : 1000;
      _debounceTimer = Timer(Duration(milliseconds: time), () {
        // ???????????????????????????????
        // По какой-то причине searchResult.loading(); не срабатывает,
        // нужно передать []
        searchResult.loading([]);

        final nameFilter = filter.copyWith(nameFilter: searchRequest.term);

        // отменяем предыдущий запрос.
        // Тут используется стрим, чтобы можно было его отменить,
        // т.к. future не отменяется.
        _loading?.cancel();
        _loading = model.perform(GetSights(nameFilter)).asStream().listen(
          (data) {
            // добавляем в историю запросы, которые удачно закончились
            model.perform(AddToHistory(searchRequest.term));
            searchResult.content(data);
          },
          onError: (error) {
            searchResult.error(error);
          },
        );
      });
    }
  }

  // Очищаем поле ввода и показываем историю
  void _onClearSearch() {
    searchText.controller.text = '';
    historyShow.accept(true);
  }

  // Переход назад
  void _onBack() => navigator.pop();
}
