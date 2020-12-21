import 'package:places/domain/sight_type.dart';

/// Место
class Sight {
  final String name;
  final double lon;
  final double lat;
  final String url;
  final String details;
  final SightType type;

  Sight({
    this.name,
    this.lon,
    this.lat,
    this.url,
    this.details,
    this.type,
  });
}
