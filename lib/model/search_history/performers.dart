import 'package:mwwm/mwwm.dart';
import 'package:places/model/repository/search_history_repository.dart';
import 'package:places/model/search_history/changes.dart';

/// Добавление запроса в историю
class AddToHistoryPerformer extends FuturePerformer<void, AddToHistory> {
  final SearchHistoryRepository repository;

  AddToHistoryPerformer(this.repository);

  @override
  Future<void> perform(AddToHistory change) async {
    repository.add(change.term);
  }
}

/// Удаление запроса из истории
class RemoveFromHistoryPerformer
    extends FuturePerformer<void, RemoveFromHistory> {
  final SearchHistoryRepository repository;

  RemoveFromHistoryPerformer(this.repository);

  @override
  Future<void> perform(RemoveFromHistory change) async {
    repository.remove(change.term);
  }
}

/// Очистка истории
class ClearHistoryPerformer extends FuturePerformer<void, ClearHistory> {
  final SearchHistoryRepository repository;

  ClearHistoryPerformer(this.repository);

  @override
  Future<void> perform(ClearHistory change) async {
    repository.clear();
  }
}

/// Получение истории
class GetHistoryPerformer extends FuturePerformer<List<String>, GetHistory> {
  final SearchHistoryRepository repository;

  GetHistoryPerformer(this.repository);

  @override
  Future<List<String>> perform(GetHistory change) {
    return repository.all();
  }
}
