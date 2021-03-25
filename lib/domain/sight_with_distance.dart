import 'package:json_annotation/json_annotation.dart';
import 'package:places/domain/sight.dart';

part 'sight_with_distance.g.dart';

/// Ответ репозитория
@JsonSerializable(explicitToJson: true)
class SightWithDistance {
  final Sight sight;
  final double distance;

  SightWithDistance(this.sight, this.distance);

  factory SightWithDistance.fromJson(Map<String, dynamic> json) =>
      _$SightWithDistanceFromJson(json);
  Map<String, dynamic> toJson() => _$SightWithDistanceToJson(this);
}
