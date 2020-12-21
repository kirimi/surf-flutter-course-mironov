/// Список доступных SVG-ресурсов для виджета [SvgIcon]
class SvgIcons {
  static const SvgData route = SvgData(
    'res/svg/route.svg',
    semanticsLabel: 'Route',
  );

  static const SvgData calendar = SvgData(
    'res/svg/calendar.svg',
    semanticsLabel: 'Calendar',
  );

  static const SvgData heart = SvgData(
    'res/svg/heart.svg',
    semanticsLabel: 'Heart',
  );

  static const SvgData info = SvgData(
    'res/svg/info.svg',
    semanticsLabel: 'Info',
  );

  static const SvgData hotel = SvgData(
    'res/svg/hotel.svg',
    semanticsLabel: 'Hotel',
  );

  static const SvgData cafe = SvgData(
    'res/svg/cafe.svg',
    semanticsLabel: 'Cafe',
  );

  static const SvgData place = SvgData(
    'res/svg/place.svg',
    semanticsLabel: 'Special place',
  );

  static const SvgData park = SvgData(
    'res/svg/park.svg',
    semanticsLabel: 'Park',
  );

  static const SvgData museum = SvgData(
    'res/svg/museum.svg',
    semanticsLabel: 'Museum',
  );

  static const SvgData restaurant = SvgData(
    'res/svg/restouraunt.svg',
    semanticsLabel: 'Restaurant',
  );
}

/// Описание SVG-ресурса
class SvgData {
  final String path;
  final String semanticsLabel;

  const SvgData(this.path, {this.semanticsLabel});
}