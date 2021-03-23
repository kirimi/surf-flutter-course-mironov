// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sight _$SightFromJson(Map<String, dynamic> json) {
  return Sight(
    id: json['id'] as int,
    name: json['name'] as String,
    photos: (json['photos'] as List)?.map((e) => e as String)?.toList(),
    details: json['details'] as String,
    type: json['type'] == null
        ? null
        : SightType.fromJson(json['type'] as Map<String, dynamic>),
    point: json['point'] == null
        ? null
        : GeoPoint.fromJson(json['point'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SightToJson(Sight instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photos': instance.photos,
      'details': instance.details,
      'point': instance.point?.toJson(),
      'type': instance.type?.toJson(),
    };
