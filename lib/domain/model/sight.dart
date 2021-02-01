import 'package:places/domain/model/geo_point.dart';
import 'package:places/domain/model/sight_type/sight_type.dart';

/// Место
class Sight {
  final int id;
  final String name;
  // todo изменить на List<String>
  final String url;
  final String details;
  final GeoPoint point;
  final SightType type;

  Sight({
    this.id,
    this.name,
    this.url,
    this.details,
    this.type,
    this.point,
  });

  @override
  String toString() {
    return 'Sight(id: $id name: $name)';
  }
}
