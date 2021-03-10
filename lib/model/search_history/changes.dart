import 'package:mwwm/mwwm.dart';

/// Добавить запрос в историю
class AddToHistory extends FutureChange<void> {
  final String term;

  AddToHistory(this.term);
}

/// Удалить запрос из истории
class RemoveFromHistory extends FutureChange<void> {
  final String term;

  RemoveFromHistory(this.term);
}

/// Очистить историю
class ClearHistory extends FutureChange<void> {}

/// Получить историю запросов
class GetHistory extends FutureChange<List<String>> {}
