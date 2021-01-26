import 'package:places/model/sight_type.dart';

/// Класс описывающий параметры фильтра, который формируется
/// на странице FiltersScreen.
/// И используется на SightListScreen, SightSearchScreen
class Filter {
  double minDistance;
  double maxDistance;
  List<SightType> types;

  Filter({
    this.minDistance,
    this.maxDistance,
    this.types,
  });

  @override
  String toString() {
    return 'min: $minDistance, max: $maxDistance, types: $types';
  }
}
