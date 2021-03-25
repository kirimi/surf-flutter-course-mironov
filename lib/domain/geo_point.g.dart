// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoPoint _$GeoPointFromJson(Map<String, dynamic> json) {
  return GeoPoint(
    lon: (json['lon'] as num)?.toDouble(),
    lat: (json['lat'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$GeoPointToJson(GeoPoint instance) => <String, dynamic>{
      'lon': instance.lon,
      'lat': instance.lat,
    };
