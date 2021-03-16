import 'package:mwwm/mwwm.dart';
import 'package:places/domain/filter.dart';

/// Сохранить фильтр
class SaveFilter extends Change<void> {
  final Filter filter;

  SaveFilter(this.filter);
}

/// Получить фильтр
class GetFilter extends Change<Filter> {}
