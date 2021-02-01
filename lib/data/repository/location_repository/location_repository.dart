import 'package:places/domain/model/geo_point.dart';

/// Репозиторий для доступа к текущему местоположению
abstract class LocationRepository {
  /// Отдает текущее местоположение в виде [GeoPoint]
  Future<GeoPoint> getCurrentLocation();
}
