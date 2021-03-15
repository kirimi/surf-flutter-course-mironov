import 'package:json_annotation/json_annotation.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';

part 'sight_type.g.dart';

/// Категория места
///
/// [code] - код тип места в api
/// доступные в api: temple, monument, park, theatre, museum, hotel, restaurant, cafe, other
@JsonSerializable(explicitToJson: true)
class SightType {
  final String name;
  final String code;
  final SvgData icon;

  const SightType({
    this.name,
    this.icon,
    this.code,
  });

  factory SightType.fromJson(Map<String, dynamic> json) =>
      _$SightTypeFromJson(json);
  Map<String, dynamic> toJson() => _$SightTypeToJson(this);

  @override
  String toString() => 'SightType(name: $name, code: $code)';
}
