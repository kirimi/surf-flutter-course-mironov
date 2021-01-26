import 'package:places/model/geo_point.dart';
import 'package:places/model/sight_type.dart';

/// Место
class Sight {
  final String name;

  final String url;
  final String details;
  final GeoPoint point;
  final SightType type;

  Sight({
    this.name,
    this.url,
    this.details,
    this.type,
    this.point,
  });

  @override
  String toString() {
    return name;
  }
}
