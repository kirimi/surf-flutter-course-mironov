import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:places/data/sight_repository/sight_api_mapper.dart';
import 'package:places/domain/core/pair.dart';
import 'package:places/domain/filter_request.dart';
import 'package:places/domain/sight.dart';
import 'package:places/interactor/repository/sight_repository.dart';

/// Репозиторий мест. Данные на сервере
class SightRepositoryNetwork implements SightRepository {
  static const String _baseUrl = 'https://test-backend-flutter.surfstudio.ru';
  static const String _getListUrl = '/place';
  static const String _addUrl = '/place';
  static const String _getFilteredUrl = '/filtered_places';

  final Dio _dio = Dio();

  SightRepositoryNetwork() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = 5000;
    _dio.options.receiveTimeout = 5000;
    _dio.options.sendTimeout = 5000;
    _dio.options.responseType = ResponseType.json;

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options) {
          print('request: ${options.data}');
        },
        onResponse: (response) {
          print('response: ${response.data}');
        },
        onError: (e) {},
      ),
    );
  }

  /// Возвращает список всех мест.
  ///
  /// [count] - количество мест в ответе, если не задано, то возвращает все.
  /// [offset] - сдвиг от начала списка.
  @override
  Future<List<Sight>> getList({int count, int offset}) async {
    // Если передать пустые параметры, то сервер отдает 400,
    // поэтому передаем параметры только если они заданы.
    Map<String, dynamic> params;
    if (count != null) params['count'] = count;
    if (offset != null) params['offset'] = offset;

    final response = await _dio.get<String>(
      _getListUrl,
      queryParameters: params,
    );

    if (response.statusCode == 200) {
      // final placesJson = await compute(_parseJson, response.data);
      final sightsJson = jsonDecode(response.data);
      final sights = (sightsJson as List)
          .map((p) => Sight().fromApiJson(p as Map<String, dynamic>))
          .toList();
      return sights;
    }
    throw Exception('Can not get list of places');
  }

  /// Возвращает List<Map<Sight, double>> список мест удовлетворяющих фильтру.
  /// value в Map -
  /// расстояние (double) до точки, если передали в [filter] текущую координату и радиус
  /// или -1.0, если filter не передали.
  @override
  Future<List<Pair<Sight, double>>> getFilteredList(
      FilterRequest filter) async {
    final body = jsonEncode(filter.toJson());
    final response = await _dio.post<String>(
      _getFilteredUrl,
      data: body,
    );
    if (response.statusCode == 200) {
      // final sightsJson = await compute(_parseJson, response.data);
      final sightsJson = jsonDecode(response.data);
      final sights = (sightsJson as List).map((p) {
        final sight = Sight().fromApiJson(p as Map<String, dynamic>);
        final distance = p['distance'] as double;
        return Pair(sight, distance);
      }).toList();

      return sights;
    }
    throw Exception('Can not get list of places');
  }

  @override
  Future<Sight> add(Sight sight) async {
    final body = jsonEncode(sight.toApiJson());
    final response = await _dio.post<String>(_addUrl, data: body);
    if (response.statusCode == 200) {
      // final sightJson = await compute(_parseJson, response.data);
      final sightJson = jsonDecode(response.data);
      return Sight().fromApiJson(sightJson as Map<String, dynamic>);
    }
    throw Exception('Can not add place');
  }

  @override
  Future<Sight> get({int id}) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete({int id}) {
    throw UnimplementedError();
  }

  @override
  Future<Sight> update(Sight place) {
    throw UnimplementedError();
  }
}

// Функция для парсинга Json в изоляте
// ignore: unused_element
dynamic _parseJson(String jsonData) {
  return jsonDecode(jsonData);
}
