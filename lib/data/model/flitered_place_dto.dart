/// Модель места на сервере с расстоянием от заданной точки
///
/// Используется в запросе [SightRepository.getFilteredList]
class FilteredPlaceDto {
  final int id;
  final double lat;
  final double lng;
  final String name;
  final List<String> urls;
  final String placeType;
  final String description;

  /// Расстояние от заданной точки
  final double distance;

  FilteredPlaceDto({
    this.id,
    this.lat,
    this.lng,
    this.name,
    this.urls,
    this.placeType,
    this.description,
    this.distance,
  });

  factory FilteredPlaceDto.fromJson(Map<String, dynamic> map) {
    return FilteredPlaceDto(
      id: map['id'] as int,
      lat: map['lat'] as double,
      lng: map['lng'] as double,
      name: map['name'] as String,
      urls: map['urls'] as List<String>,
      placeType: map['placeType'] as String,
      description: map['description'] as String,
      distance: map['distance'] as double,
    );
  }

  @override
  String toString() {
    return 'FilteredPlaceDto(id:$id, name:$name, distance: $distance)';
  }
}
