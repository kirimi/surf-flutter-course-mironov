import 'package:geolocator/geolocator.dart';
import 'package:places/domain/geo_point.dart';
import 'package:places/model/repository/location_repository.dart';

class LocationRepositoryReal implements LocationRepository {
  @override
  Future<GeoPoint> getCurrentLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return GeoPoint(lat: position.latitude, lon: position.longitude);
  }

  /// Последнее известное местоположение
  @override
  Future<GeoPoint> getLastKnownLocation() async {
    final position = await Geolocator.getLastKnownPosition();
    return GeoPoint(lat: position.latitude, lon: position.longitude);
  }
}
