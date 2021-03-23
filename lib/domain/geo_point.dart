import 'package:json_annotation/json_annotation.dart';

part 'geo_point.g.dart';

/// Класс, описывающий гео-координату точки.
@JsonSerializable(explicitToJson: true)
class GeoPoint {
  final double lon;
  final double lat;

  GeoPoint({this.lon, this.lat});

  factory GeoPoint.fromJson(Map<String, dynamic> json) =>
      _$GeoPointFromJson(json);
  Map<String, dynamic> toJson() => _$GeoPointToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeoPoint &&
          runtimeType == other.runtimeType &&
          lon == other.lon &&
          lat == other.lat;

  @override
  int get hashCode => lon.hashCode ^ lat.hashCode;

  @override
  String toString() {
    return 'GeoPoint(lon: $lon, lat: $lat)';
  }
}
