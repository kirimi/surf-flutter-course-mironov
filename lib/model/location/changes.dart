import 'package:mwwm/mwwm.dart';
import 'package:places/domain/geo_point.dart';

/// Получить текущую геопозицию
class GetCurrentLocation extends FutureChange<GeoPoint> {}

/// Поучить последнюю известную геопозицию
class GetLastKnownLocation extends FutureChange<GeoPoint> {}
