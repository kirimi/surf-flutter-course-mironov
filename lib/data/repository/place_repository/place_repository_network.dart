import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:places/data/model/filter_request.dart';
import 'package:places/data/model/flitered_place_dto.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/place_repository/place_repository.dart';

/// Репозиторий мест. Данные на сервере
class PlaceRepositoryNetwork implements PlaceRepository {
  static const String _baseUrl = 'https://test-backend-flutter.surfstudio.ru';
  static const String _getListUrl = '/place';
  static const String _addUrl = '/place';
  static const String _getFilteredUrl = '/filtered_places';

  final Dio _dio = Dio();

  PlaceRepositoryNetwork() {
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

  @override
  Future<List<PlaceDto>> getList({int count, int offset}) async {
    // Если передать пустые параметры, то сервер отдает 400,
    // поэтому передаем параметры только если они заданы.
    Map<String, dynamic> params;
    if (count != null) params['count'] = count;
    if (offset != null) params['offset'] = offset;

    final response =
        await _dio.get<String>(_getListUrl, queryParameters: params);

    if (response.statusCode == 200) {
      // final placesJson = await compute(_parseJson, response.data);
      final placesJson = jsonDecode(response.data);
      final places = (placesJson as List)
          .map((p) => PlaceDto.fromJson(p as Map<String, dynamic>))
          .toList();
      return places;
    }
    throw Exception('Can not get list of places');
  }

  @override
  Future<PlaceDto> get({int id}) {
    throw UnimplementedError();
  }

  @override
  Future<List> getFilteredList(FilterRequest filter) async {
    final body = jsonEncode(filter.toJson());
    final response = await _dio.post<String>(_getFilteredUrl, data: body);
    if (response.statusCode == 200) {
      // final placesJson = await compute(_parseJson, response.data);
      final placesJson = jsonDecode(response.data);
      List places;
      if (filter.radius != null && filter.lat != null && filter.lng != null) {
        places = (placesJson as List)
            .map((p) => FilteredPlaceDto.fromJson(p as Map<String, dynamic>))
            .toList();
      } else {
        places = (placesJson as List)
            .map((p) => PlaceDto.fromJson(p as Map<String, dynamic>))
            .toList();
      }
      return places;
    }
    throw Exception('Can not get list of places');
  }

  @override
  Future<PlaceDto> add(PlaceDto place) async {
    final body = jsonEncode(place.toJson());
    final response = await _dio.post<String>(_addUrl, data: body);
    if (response.statusCode == 200) {
      // final placeMap = await compute(_parseJson, response.data);
      final placeMap = jsonDecode(response.data);
      return PlaceDto.fromJson(placeMap as Map<String, dynamic>);
    }
    throw Exception('Can not add place');
  }

  @override
  Future<void> delete({int id}) {
    throw UnimplementedError();
  }

  @override
  Future<PlaceDto> update(PlaceDto place) {
    throw UnimplementedError();
  }
}

// Функция для парсинга Json в изоляте
dynamic _parseJson(String jsonData) {
  return jsonDecode(jsonData);
}
