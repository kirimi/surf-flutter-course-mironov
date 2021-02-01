import 'package:places/data/model/flitered_place_dto.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/domain/model/geo_point.dart';
import 'package:places/domain/model/sight.dart';
import 'package:places/domain/model/sight_type/default_sight_types.dart';

/// Мапперы.
/// Производят преобразование моделей из разных слоев

class SightMapper {
  /// Преобразование из [PlaceDto] в [Sight]
  static Sight fromPlaceDto(PlaceDto from) => Sight(
        id: from.id,
        name: from.name,
        point: GeoPoint(
          lat: from.lat,
          lon: from.lng,
        ),
        type: getSightTypeByCode(from.placeType),
        // todo тип Sight.url измениться.
        url: from.urls.first,
        details: from.description,
      );

  /// Преобразование из [FilteredPlaceDto] в [Sight]
  static Sight fromFilteredPlaceDto(FilteredPlaceDto from) => Sight(
        id: from.id,
        name: from.name,
        point: GeoPoint(
          lat: from.lat,
          lon: from.lng,
        ),
        type: getSightTypeByCode(from.placeType),
        url: from.urls.first,
        details: from.description,
      );
}

class PlaceDtoMapper {
  /// Преобразование из [Sight] в [PlaceDto]
  static PlaceDto fromSight(Sight from) => PlaceDto(
        id: from.id,
        name: from.name,
        lat: from.point.lat,
        lng: from.point.lon,
        placeType: from.type.code,
        description: from.details,
        urls: [from.url],
      );
}
