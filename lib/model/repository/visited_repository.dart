import 'package:places/domain/sight.dart';

/// Интерфейс для репозитория мест "Посещенные"
abstract class VisitedRepository {
  /// Возвращает список id мест "Посещенные"
  Future<List<Sight>> getList();

  /// Добавляет место с [id] в список "Посещенные"
  Future<void> add(Sight sight);

  /// Удаляет место с [id] из списка "Посещенные"
  Future<void> remove(int id);

  /// Возвращает включено ли место [id] в список "Посещенные"
  Future<bool> isVisited(int id);
}
