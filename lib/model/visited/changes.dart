import 'package:mwwm/mwwm.dart';
import 'package:places/domain/sight.dart';

/// Добавить в список посещенных мест
class AddToVisited extends FutureChange<void> {
  final Sight sight;

  AddToVisited(this.sight);
}

/// Удалить из посещенных мест
class RemoveFromVisited extends FutureChange<void> {
  final Sight sight;

  RemoveFromVisited(this.sight);
}

/// Получить список посещенных мест
class GetVisitedSights extends FutureChange<List<Sight>> {}
