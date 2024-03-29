import 'package:json_annotation/json_annotation.dart';
import 'package:places/domain/geo_point.dart';
import 'package:places/domain/sight_type/sight_type.dart';

part 'sight.g.dart';

/// Место
@JsonSerializable(explicitToJson: true)
class Sight {
  final int id;
  final String name;
  final List<String> photos;
  final String details;
  final GeoPoint point;
  final SightType type;

  Sight({
    this.id,
    this.name,
    this.photos,
    this.details,
    this.type,
    this.point,
  });

  factory Sight.fromJson(Map<String, dynamic> json) => _$SightFromJson(json);
  Map<String, dynamic> toJson() => _$SightToJson(this);

  Sight copyWith({
    int id,
    String name,
    List<String> photos,
    String details,
    GeoPoint point,
    SightType type,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name)) &&
        (photos == null || identical(photos, this.photos)) &&
        (details == null || identical(details, this.details)) &&
        (point == null || identical(point, this.point)) &&
        (type == null || identical(type, this.type))) {
      return this;
    }

    return Sight(
      id: id ?? this.id,
      name: name ?? this.name,
      photos: photos ?? this.photos,
      details: details ?? this.details,
      point: point ?? this.point,
      type: type ?? this.type,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Sight && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Sight(id: $id name: $name)';
  }
}
