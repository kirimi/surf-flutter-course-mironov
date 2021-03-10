import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:places/model/search_history/changes.dart';
import 'package:relation/relation.dart';

/// wm для виджета с историей поиска
class HistoryWm extends WidgetModel {
  HistoryWm(
    WidgetModelDependencies baseDependencies,
    Model model, {
    this.onSelect,
  }) : super(baseDependencies, model: model);

  /// Калбек при выборе элемента истоиии
  final ValueChanged<String> onSelect;

  /// История поиска
  final history = EntityStreamedState<List<String>>(EntityState.loading([]));

  /// Добавить в историю
  final addToHistory = Action<String>();

  /// Удалить из истории
  final removeFromHistory = Action<String>();

  /// Очистить историю
  final clearHistory = Action<void>();

  @override
  void onBind() {
    super.onBind();
    subscribe(addToHistory.stream, _onAddToHistory);
    subscribe(removeFromHistory.stream, _onRemoveFromHistory);
    subscribe(clearHistory.stream, (_) => _onClearHistory());
  }

  @override
  void onLoad() {
    super.onLoad();
    _onLoad();
  }

  Future<void> _onLoad({bool silent = false}) async {
    if (!silent) {
      history.loading([]);
    }
    doFuture<List<String>>(
      model.perform(GetHistory()),
      (res) => history.content(res),
    );
  }

  void _onAddToHistory(String term) {
    model.perform(AddToHistory(term));
    _onLoad(silent: true);
  }

  void _onRemoveFromHistory(String term) {
    model.perform(RemoveFromHistory(term));
    _onLoad(silent: true);
  }

  void _onClearHistory() {
    model.perform(ClearHistory());
    _onLoad(silent: true);
  }
}
