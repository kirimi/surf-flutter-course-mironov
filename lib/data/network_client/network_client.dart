import 'package:dio/dio.dart';
import 'package:places/interactor/repository/exceptions/internet_exception.dart';
import 'package:places/interactor/repository/exceptions/network_exception.dart';

/// Клиент для сетевого взаимодействия
///
/// Совершает запросы к серверу
/// Если успешно, то возвращает результат в виде строки
/// Если сервер вернул что-то отличное от 200, то выкидывает [InternetException]
/// При отсутствии интернета или других проблемах соединения, то выкидывает [NetworkException]
class NetworkClient {
  final Dio _dio = Dio();

  NetworkClient({String baseUrl}) {
    _dio.options.baseUrl = baseUrl;
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

  /// Делает POST запрос
  Future<String> post(String url, String body) async {
    try {
      final response = await _dio.post<String>(url, data: body);
      if (response.statusCode != 200) {
        throw NetworkException(
            url, response.statusCode, response.statusMessage);
      }
      return response.data;
    } catch (e) {
      throw _mapException(e);
    }
  }

  /// Делает GET запрос
  Future<String> get(String url, Map<String, dynamic> params) async {
    try {
      final response = await _dio.get<String>(url, queryParameters: params);
      if (response.statusCode != 200) {
        throw NetworkException(
            url, response.statusCode, response.statusMessage);
      }
      return response.data;
    } catch (e) {
      throw _mapException(e);
    }
  }

  dynamic _mapException(dynamic e) {
    if (e is DioError) {
      return InternetException(e.request.path, e.message);
    } else if (e is NetworkException) {
      return e;
    }
    return e;
  }
}
