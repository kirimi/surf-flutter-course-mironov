import 'package:places/data/repository/location_repository/location_repository.dart';
import 'package:places/domain/model/geo_point.dart';

/// Моковые данные для текущего местоположения
class LocationRepositoryMock implements LocationRepository {
  /// Отдает местоположение с задержкой 500ms
  @override
  Future<GeoPoint> getCurrentLocation() {
    return Future.delayed(const Duration(milliseconds: 500), () {
      // todo тут получить реальные координаты
      return GeoPoint(lon: 59.685994, lat: 30.433278);
    });
  }
}
