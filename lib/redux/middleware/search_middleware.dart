import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/filter_request.dart';
import 'package:places/domain/geo_point.dart';
import 'package:places/domain/sight.dart';
import 'package:places/interactor/repository/location_repository.dart';
import 'package:places/interactor/repository/sight_repository.dart';
import 'package:places/interactor/search_history_interactor.dart';
import 'package:places/redux/action/search_action.dart';
import 'package:places/redux/state/search_state.dart';
import 'package:redux/redux.dart';

/// Обработка запроса поиска по action [RequestSearchAction]
/// Ходит в репозиторий за данными,
/// в начале выполнения запроса диспатчит [OnLoadingSearchAction]
/// с случае успеха [OnResultSearchAction]
/// в случае ошибки [OnErrorSearchAction]
class RequestSearchMiddleware implements MiddlewareClass<SearchState> {
  RequestSearchMiddleware({
    @required this.sightRepository,
    @required this.locationRepository,
    @required this.historyInteractor,
  })  : assert(sightRepository != null),
        assert(locationRepository != null),
        assert(historyInteractor != null);

  final SightRepository sightRepository;
  final LocationRepository locationRepository;
  final SearchHistoryInteractor historyInteractor;

  // Подписка для отмены текущего запроса
  StreamSubscription<List> _loading;

  // Таймер для паузы между запросом и вводом пользователя.
  Timer _debounceTimer;

  @override
  void call(Store<SearchState> store, dynamic action, NextDispatcher next) {
    if (action is RequestSearchAction) {
      _debounceTimer?.cancel();
      if (action.term != '') {
        // делаем запрос только через секунду после последнего ввода пользователя
        final int time = action.performNow ? 0 : 1000;
        _debounceTimer = Timer(Duration(milliseconds: time), () {
          store.dispatch(OnLoadingSearchAction());
          // отменяем предыдущий запрос.
          _loading?.cancel();
          _loading = _requestFilteredSights(action.term, action.filter)
              .asStream()
              .listen(
            (searchResult) {
              // добавляем в историю запросы, которые удачно закончились
              historyInteractor.add(action.term);
              store.dispatch(OnResultSearchAction(searchResult));
            },
            onError: (error) {
              store.dispatch(OnErrorSearchAction(error.toString()));
            },
          );
        });
      }
    } else {
      next(action);
    }
  }

  // Загружает места, которые соответствуют фильтру [filter]
  Future<List<Sight>> _requestFilteredSights(String term, Filter filter) async {
    FilterRequest filterReq;

    if (filter.maxDistance != null) {
      // Если задан гео-поиск, то получаем текущее местоположение
      // и формируем соответствующий запрос
      final GeoPoint currLoc = await locationRepository.getCurrentLocation();
      filterReq = FilterRequest(
        lat: currLoc.lat,
        lng: currLoc.lon,
        radius: filter.maxDistance,
        typeFilter: filter.types.map((e) => e.code).toList(),
        nameFilter: term,
      );
    } else {
      filterReq = FilterRequest(
        typeFilter: filter.types.map((e) => e.code).toList(),
        nameFilter: term,
      );
    }

    final result = await sightRepository.getFilteredList(filterReq);
    final sights = result.map((e) => e.first).toList();
    return sights;
  }
}
