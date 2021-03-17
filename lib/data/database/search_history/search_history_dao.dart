import 'package:moor/moor.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/database/search_history/search_history.dart';

part 'search_history_dao.g.dart';

/// DAO для доступа к таблице истории запросов поиска
@UseDao(tables: [SearchHistories])
class SearchHistoryDao extends DatabaseAccessor<AppDatabase> with _$SearchHistoryDaoMixin {
  SearchHistoryDao(AppDatabase attachedDatabase) : super(attachedDatabase);

  /// Получить все прошлы запросы
  Future<List<String>> getAll() async {
    // сортируем по убыванию id. Наверху самые новые
    final all = await (select(searchHistories)
          ..orderBy(
            [(t) => OrderingTerm.desc(t.id)],
          ))
        .get();
    return all.map((SearchHistory sh) => sh.request).toList();
  }

  /// Добавление запроса
  ///
  /// Сначала удаляет прошлый запрос [request], и добавляет в конец новый
  Future<int> add(String request) async {
    // Удаляем прошлые запросы с [request], чтобы не повторялись
    await remove(request);
    return into(searchHistories).insert(
      SearchHistoriesCompanion(
        request: Value(request),
      ),
    );
  }

  // Удаление запроса
  Future<void> remove(String request) async {
    return (delete(searchHistories)
          ..where(
            (tbl) => tbl.request.equals(request),
          ))
        .go();
  }

  /// Очистка таблицы
  Future<void> clear() async {
    return delete(searchHistories).go();
  }
}
