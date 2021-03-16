// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Filter _$FilterFromJson(Map<String, dynamic> json) {
  return Filter(
    minDistance: (json['minDistance'] as num)?.toDouble(),
    maxDistance: (json['maxDistance'] as num)?.toDouble(),
    types: (json['types'] as List)
        ?.map((e) =>
            e == null ? null : SightType.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    nameFilter: json['nameFilter'] as String,
  );
}

Map<String, dynamic> _$FilterToJson(Filter instance) => <String, dynamic>{
      'minDistance': instance.minDistance,
      'maxDistance': instance.maxDistance,
      'types': instance.types?.map((e) => e?.toJson())?.toList(),
      'nameFilter': instance.nameFilter,
    };
