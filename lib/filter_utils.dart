import 'dart:math';

import 'package:places/domain/geo_point.dart';

import 'domain/filter.dart';
import 'domain/sight.dart';

/// Отфильтровывает места по фильтру [filter]
/// Только категории из фильтра или если нет категорий в фильтре, то все.
/// Затем, только те, что попадают в нужный радиус
List<Sight> filteredSightList(
  List<Sight> sights,
  Filter filter,
  GeoPoint currentPoint,
) {
  final filtered = sights
      // Только категории из фильтра или если нет категорий в фильтре, то все.
      .where(
          (sight) => filter.types.contains(sight.type) || filter.types.isEmpty)
      // Только те, что попадают в нужный радиус
      .where((sight) => isPointInsideRange(
            point: currentPoint,
            center: sight.point,
            minDistance: filter.minDistance,
            maxDistance: filter.maxDistance,
          ));
  return filtered.toList();
}

/// Возвращает лежит ли точка [point] в радисе между minDistance и maxDistance
/// от [center]. [minDistance]/[maxDistance] в метрах.
bool isPointInsideRange({
  GeoPoint point,
  GeoPoint center,
  double minDistance,
  double maxDistance,
}) {
  const double ky = 40000000 / 360;
  final double kx = cos(pi * point.lat / 180.0) * ky;
  final double dx = (point.lon - center.lon).abs() * kx;
  final double dy = (point.lat - center.lat).abs() * ky;
  final double dis = sqrt(dx * dx + dy * dy);
  return dis >= minDistance && dis <= maxDistance;
}
