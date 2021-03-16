import 'package:mwwm/mwwm.dart';
import 'package:places/domain/filter.dart';
import 'package:places/model/filter/changes.dart';
import 'package:places/model/repository/storage_repository.dart';

/// Сохранение фильтра
class SaveFilterPerformer extends Performer<void, SaveFilter> {
  final StorageRepository repository;

  SaveFilterPerformer(this.repository);

  @override
  void perform(SaveFilter change) => repository.filter = change.filter;
}

/// Получение фильтра
class GetFilterPerformer extends Performer<Filter, GetFilter> {
  final StorageRepository repository;

  GetFilterPerformer(this.repository);

  @override
  Filter perform(GetFilter change) => repository.filter;
}
