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

  FilterRequest copyWith({
    double lat,
    double lng,
    double radius,
    List<String> typeFilter,
    String nameFilter,
  }) {
    if ((lat == null || identical(lat, this.lat)) &&
        (lng == null || identical(lng, this.lng)) &&
        (radius == null || identical(radius, this.radius)) &&
        (typeFilter == null || identical(typeFilter, this.typeFilter)) &&
        (nameFilter == null || identical(nameFilter, this.nameFilter))) {
      return this;
    }

    return FilterRequest(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      radius: radius ?? this.radius,
      typeFilter: typeFilter ?? this.typeFilter,
      nameFilter: nameFilter ?? this.nameFilter,
    );
  }

  /// преобразуем в map
  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
      'radius': radius,
      'typeFilter': typeFilter,
      'nameFilter': nameFilter,
      // но не включаем поля, где значения null или пустой список
    }..removeWhere(
        (key, value) => value == null || (value is Iterable && value.isEmpty));
  }
}
