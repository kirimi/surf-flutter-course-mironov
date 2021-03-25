import 'package:places/domain/sight.dart';

/// Интерфейс для репозитория мест "Хочу посетить"
abstract class FavoritesRepository {
  /// Возвращает список мест "Хочу посетить"
  Future<List<Sight>> getList();

  /// Добавляет место в список "Хочу посетить"
  Future<void> add(Sight sight);

  /// Удаляет место с [id] из списка "Хочу посетить"
  Future<void> remove(int id);

  /// Возвращает включено ли место [id] в список "Хочу посетить"
  Future<bool> isFavorite(int id);
}
