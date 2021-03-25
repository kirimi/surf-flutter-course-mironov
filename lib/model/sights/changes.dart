import 'package:mwwm/mwwm.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/sight.dart';

/// Добавление нового места
class AddNewSight extends FutureChange<void> {
  final Sight sight;

  AddNewSight(this.sight);
}

/// Получение списка мест, согласно фильтру
class GetSights extends FutureChange<List<Sight>> {
  final Filter filter;
  final bool force;

  GetSights(this.filter, {this.force = false});
}
