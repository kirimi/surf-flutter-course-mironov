import 'package:places/data/repository/location_repository/location_repository.dart';
import 'package:places/domain/model/geo_point.dart';

/// Моковые данные для текущего местоположения
class LocationRepositoryMock implements LocationRepository {
  GeoPoint _currentLocation;

  /// Отдает местоположение с задержкой 500ms
  @override
  Future<GeoPoint> getCurrentLocation() {
    if (_currentLocation != null) {
      return Future.value(_currentLocation);
    } else {
      _currentLocation = GeoPoint(lon: 59.685994, lat: 30.433278);
      return Future.delayed(const Duration(milliseconds: 10), () {
        return Future.value(_currentLocation);
      });
    }
  }
}
