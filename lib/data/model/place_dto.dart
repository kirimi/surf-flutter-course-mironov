/// Модель места на сервере
class PlaceDto {
  final int id;
  final double lat;
  final double lng;
  final String name;
  final List<String> urls;
  final String placeType;
  final String description;

  PlaceDto({
    this.id,
    this.lat,
    this.lng,
    this.name,
    this.urls,
    this.placeType,
    this.description,
  });

  factory PlaceDto.fromJson(Map<String, dynamic> map) {
    // В поле url ожидается массив строк, но возможно там что-то другое
    List<String> urls;
    try {
      urls = (map['urls'] as List).map((e) => e.toString()).toList();
    } catch (e) {
      urls = [];
    }

    return PlaceDto(
      id: map['id'] as int,
      lat: map['lat'] as double,
      lng: map['lng'] as double,
      name: map['name'] as String,
      urls: urls,
      placeType: map['placeType'] as String,
      description: map['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      'lat': lat,
      'lng': lng,
      'name': name,
      'urls': urls,
      'placeType': placeType,
      'description': description,
    };

    // Если id не задан, то не включаем его в json
    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  PlaceDto copyWith({
    int id,
    double lat,
    double lng,
    String name,
    List<String> urls,
    String placeType,
    String description,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (lat == null || identical(lat, this.lat)) &&
        (lng == null || identical(lng, this.lng)) &&
        (name == null || identical(name, this.name)) &&
        (urls == null || identical(urls, this.urls)) &&
        (placeType == null || identical(placeType, this.placeType)) &&
        (description == null || identical(description, this.description))) {
      return this;
    }

    return PlaceDto(
      id: id ?? this.id,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      name: name ?? this.name,
      urls: urls ?? this.urls,
      placeType: placeType ?? this.placeType,
      description: description ?? this.description,
    );
  }

  @override
  String toString() {
    return 'PlaceDto(id:$id, name:$name)';
  }
}
