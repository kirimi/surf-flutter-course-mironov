import 'package:places/domain/sight_type.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';

/// Предустановленные категории мест, используются в фильтре.
final List<SightType> defaultSightTypes = [
  SightType(
    name: 'Кинотеатр',
    iconName: 'cinema',
  ),
  SightType(
    name: 'Ресторан',
    iconName: 'restaurant',
  ),
  SightType(
    name: 'Особое место',
    iconName: 'special',
  ),
  SightType(
    name: 'Парк',
    iconName: 'park',
  ),
  SightType(
    name: 'Музей',
    iconName: 'museum',
  ),
  SightType(
    name: 'Кафе',
    iconName: 'cafe',
  ),
];

/// Функция возвращает [IconData] по имени [iconName] иконки,
/// если нет такой, то иконку по-умолчанию
SvgData getIconByName(String iconName) {
  SvgData icon;
  switch (iconName) {
    case 'cinema':
      icon = SvgIcons.hotel;
      break;
    case 'restaurant':
      icon = SvgIcons.restaurant;
      break;
    case 'special':
      icon = SvgIcons.place;
      break;
    case 'park':
      icon = SvgIcons.park;
      break;
    case 'museum':
      icon = SvgIcons.museum;
      break;
    case 'cafe':
      icon = SvgIcons.cafe;
      break;
    default:
      icon = SvgIcons.info;
  }
  return icon;
}
