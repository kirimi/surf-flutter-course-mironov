import 'package:places/data/model/filter_request.dart';
import 'package:places/data/model/place_dto.dart';

abstract class PlaceRepository {
  /// Добавляет место,
  /// в случае успеха возвращает [PlaceDto] с назначенным id
  Future<PlaceDto> add(PlaceDto place);

  /// Возвращает список всех мест.
  ///
  /// [count] - количество мест в ответе, если не задано, то возвращает все.
  /// [offset] - сдвиг от начала списка.
  Future<List<PlaceDto>> getList({
    int count,
    int offset,
  });

  /// Возвращает место.
  ///
  /// [id] - идентификатор места
  Future<PlaceDto> get({int id});

  /// Обновляет место.
  ///
  /// [place] - обновленные данные. Должен быть установлен [place.id]
  /// Возвращает обновленное место.
  Future<PlaceDto> update(PlaceDto place);

  /// Удаляет место.
  ///
  /// [id] - идентификатор места
  Future<void> delete({int id});

  /// Возвращает список мест удовлетворяющих фильтру.
  Future<List> getFilteredList(FilterRequest filter);
}
