// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sight_with_distance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SightWithDistance _$SightWithDistanceFromJson(Map<String, dynamic> json) {
  return SightWithDistance(
    json['sight'] == null
        ? null
        : Sight.fromJson(json['sight'] as Map<String, dynamic>),
    (json['distance'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$SightWithDistanceToJson(SightWithDistance instance) =>
    <String, dynamic>{
      'sight': instance.sight?.toJson(),
      'distance': instance.distance,
    };
