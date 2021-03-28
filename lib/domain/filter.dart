import 'package:json_annotation/json_annotation.dart';
import 'package:places/domain/sight_type/sight_type.dart';
import 'package:places/environment/environment.dart';

part 'filter.g.dart';

/// Класс описывающий параметры фильтра, который формируется
/// на странице FiltersScreen.
/// И используется на SightListScreen, SightSearchScreen
@JsonSerializable(explicitToJson: true)
class Filter {
  double minDistance;
  double maxDistance;
  List<SightType> types;
  String nameFilter;

  Filter({
    this.minDistance,
    this.maxDistance,
    this.types,
    this.nameFilter,
  });

  Filter.initial() {
    minDistance = Environment.instance.buildConfig.minRange;
    maxDistance = Environment.instance.buildConfig.maxRange;
    types = [];
  }

  Filter copyWith({
    double minDistance,
    double maxDistance,
    List<SightType> types,
    String nameFilter,
  }) {
    return Filter(
      minDistance: minDistance ?? this.minDistance,
      maxDistance: maxDistance ?? this.maxDistance,
      types: types ?? this.types,
      nameFilter: nameFilter ?? this.nameFilter,
    );
  }

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);
  Map<String, dynamic> toJson() => _$FilterToJson(this);

  @override
  String toString() {
    return 'min: $minDistance, max: $maxDistance, types: $types';
  }
}
