import 'dart:io';

import 'package:places/data/network_client/network_client.dart';
import 'package:places/model/repository/exceptions/internet_exception.dart';

/// NetworkClient который всегда всегда [InternetException], нет интернета
class NetworkClientNoInternet implements NetworkClient {
  @override
  Future<String> get(String url, Map<String, dynamic> params) {
    throw InternetException(url, 'no internet');
  }

  @override
  Future<String> post(String url, dynamic body) {
    throw InternetException(url, 'no internet');
  }

  @override
  Future<String> uploadPhotos(String url, List<File> photos) {
    throw InternetException(url, 'no internet');
  }
}
