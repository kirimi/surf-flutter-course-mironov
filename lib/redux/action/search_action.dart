import 'package:flutter/material.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/sight.dart';

abstract class SearchAction {}

/// Запрос на поиск по подстроке [term] с учетом фильтра [filter]
/// [performNow] определяет выполнится запрос сразу
/// или спустя время ожидания следующего пользовательского ввода
@immutable
class RequestSearchAction extends SearchAction {
  final String term;
  final Filter filter;
  final bool performNow;

  RequestSearchAction(this.term, {this.filter, this.performNow});
}

/// Происходит загрузка
@immutable
class OnLoadingSearchAction extends SearchAction {}

/// Получен результат запроса
@immutable
class OnResultSearchAction extends SearchAction {
  final List<Sight> sights;

  OnResultSearchAction(this.sights);
}

/// Ошибка при выполнении запроса
@immutable
class OnErrorSearchAction extends SearchAction {
  final String message;

  OnErrorSearchAction(this.message);
}

/// показать историю запросов
@immutable
class HistorySearchAction extends SearchAction {}
