///  Модель тела запроса списка мест с фильтром
class FilterRequest {
  /// Широта
  final double lat;

  /// Долгота
  final double lng;

  /// Радиус поиска
  final double radius;

  /// Фильтр со списком типов мест
  final List<String> typeFilter;

  /// Фильтр по наименованию места
  final String nameFilter;

  const FilterRequest({
    this.lat,
    this.lng,
    this.radius,
    this.typeFilter,
    this.nameFilter,
  });

  factory FilterRequest.fromJson(Map<String, dynamic> json) {
    return FilterRequest(
      lat: json['lat'] as double,
      lng: json['lng'] as double,
      radius: json['radius'] as double,
      typeFilter: json['typeFilter'] as List<String>,
      nameFilter: json['nameFilter'] as String,
    );
  }

  /// преобразуем в map, но не включаем поля, где значения null
  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
      'radius': radius,
      'typeFilter': typeFilter,
      'nameFilter': nameFilter,
    }..removeWhere((key, value) => value == null);
  }
}
