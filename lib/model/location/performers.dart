import 'package:mwwm/mwwm.dart';
import 'package:places/domain/geo_point.dart';
import 'package:places/model/location/changes.dart';
import 'package:places/model/repository/location_repository.dart';

/// Получение текущей позиции пользователя
class GetCurrentLocationPerformer
    extends FuturePerformer<GeoPoint, GetCurrentLocation> {
  final LocationRepository repository;

  GetCurrentLocationPerformer(this.repository);

  @override
  Future<GeoPoint> perform(GetCurrentLocation change) {
    return repository.getCurrentLocation();
  }
}
