import 'package:places/domain/sight_type.dart';

/// Класс описывающий параметры фильтра, который формируется
/// на странице FiltersScreen.
/// И используется на SightListScreen, SightSearchScreen
class Filter {
  final double minDistance;
  final double maxDistance;
  final List<SightType> types;

  const Filter({
    this.minDistance,
    this.maxDistance,
    this.types,
  });

  @override
  String toString() {
    return 'min: $minDistance, max: $maxDistance, types: $types';
  }
}
