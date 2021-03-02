import 'package:flutter/cupertino.dart';
import 'package:places/domain/sight.dart';

abstract class SearchState {}

/// Идет загрузка
@immutable
class LoadingSearchState extends SearchState {}

/// Результаты запроса
@immutable
class ResultSearchState extends SearchState {
  final List<Sight> sights;

  ResultSearchState(this.sights);
}

/// Произошла ошибка в запросе
@immutable
class ErrorSearchState extends SearchState {
  final String message;

  ErrorSearchState(this.message);
}

/// Показываем историю поиска на ui
@immutable
class HistorySearchState extends SearchState {}
