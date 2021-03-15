// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sight_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SightType _$SightTypeFromJson(Map<String, dynamic> json) {
  return SightType(
    name: json['name'] as String,
    icon: json['icon'] == null
        ? null
        : SvgData.fromJson(json['icon'] as Map<String, dynamic>),
    code: json['code'] as String,
  );
}

Map<String, dynamic> _$SightTypeToJson(SightType instance) => <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'icon': instance.icon?.toJson(),
    };
